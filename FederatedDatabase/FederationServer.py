import grpc
from concurrent import futures
import federation_pb2
import federation_pb2_grpc
import mysql.connector
from mysql.connector import Error
from FederationQuery import FederationQuery
import tenseal as ts
from FederationConfig import federated_config


class FederationServiceServicer(federation_pb2_grpc.FederationServiceServicer):
    def __init__(self, config):
        try:
            # 初始化连接和游标
            self.connection = mysql.connector.connect(**config)
            self.cursor = self.connection.cursor()
            # 初始化所属的小型数据库
            self.database_address = self.get_database_address()
            print('Connection successful')
        except Error as e:
            print("Error while connecting to MySQL", e)
        # 初始化查询工具类
        self.context = self.generate_encrypt_context()
        self.querier = FederationQuery(self.database_address, self.context)

    def get_database_address(self):
        try:
            # 定义参数化查询
            query = "SELECT database_address FROM address"
            # 执行查询
            self.cursor.execute(query)
            # 获取查询结果
            records = self.cursor.fetchall()
            results = []
            for record in records:
                results.append(record[0])
            # 返回结果
            return results
        except Error as e:
            print("Error while connecting to MySQL", e)

    @staticmethod
    def generate_encrypt_context():
        context = ts.context(
            ts.SCHEME_TYPE.CKKS,
            poly_modulus_degree=8192,
            coeff_mod_bit_sizes=[40, 21, 21, 40]
        )
        context.generate_galois_keys()
        context.global_scale = 2 ** 21
        return context

    def CheckData(self, request, context):
        # 接受数据
        query_type = request.query_type
        position_x = request.position_x
        position_y = request.position_y
        query_num = request.query_num
        encrypt = request.encrypt
        final_results = []
        if query_type == federation_pb2.Nearest:
            if not encrypt:
                results = self.querier.nearest_query(position_x, position_y, query_num)
            else:
                results = self.querier.encrypted_nearest_query(position_x, position_y, query_num)
        else:
            results = self.querier.anti_nearest_query(position_x, position_y)
        for result in results:
            final_results.append(federation_pb2.CheckResult(
                position_x=result[0],
                position_y=result[1],
                database_id=result[2]))

        return federation_pb2.CheckResponse(
            results=final_results,
        )

    def AddDatabase(self, request, context):
        try:
            # 执行插入
            insert = """
                        INSERT INTO address(database_address)
                        VALUES(%s)
                        """
            values = (request.address,)
            self.cursor.execute(insert, values)
            # 提交
            self.connection.commit()
            return federation_pb2.AddResponse(
                add_result=federation_pb2.Success)
        except Error as e:
            # 出错要回滚
            self.connection.rollback()
            print("Error while connecting to MySQL", e)
            return federation_pb2.AddResponse(
                add_result=federation_pb2.Fail
            )

    def CompareDist(self, request, context):
        dis_diff = ts.ckks_vector_from(self.context, request.dis_diff).decrypt()
        # 注意解密后的结果为一个向量
        if dis_diff[0] < 0:
            answer = -1
        else:
            answer = 1
        # 返回比较结果
        return federation_pb2.DiffResponse(
            cmp_result=answer
        )


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    servicer = FederationServiceServicer(federated_config)
    federation_pb2_grpc.add_FederationServiceServicer_to_server(servicer, server)
    server.add_insecure_port('[::]:50051')
    print("Server is running on port 50051...")
    server.start()
    server.wait_for_termination()


if __name__ == '__main__':
    serve()
