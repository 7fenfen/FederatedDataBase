import grpc
import time
from concurrent import futures
import federation_pb2
import federation_pb2_grpc
import mysql.connector
from mysql.connector import Error
from FederationQuery import FederationQuery
import tenseal as ts

federated_config = {
    'host': '112.4.115.127',
    'port': 3312,
    'database': 'zhx_0001',
    'user': 'zhx_0001',
    'password': 'ARfDhjdBbBmzrMaY'
}


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
        """处理AddDatabase请求"""
        # TODO: 实现函数逻辑
        return federation_pb2.AddResponse()

    def GenerateMap(self, request, context):
        """处理GenerateMap请求"""
        # TODO: 实现函数逻辑
        return federation_pb2.MapResponse()

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

    def test(self):
        federated_query = FederationQuery(self.database_address, self.context)

        # test1,非加密最近邻
        time1 = time.time()
        results = federated_query.nearest_query(150, 150, 10)
        print(f"Query Type: Nearest, X:150, Y:150, QueryNum:10")
        for result in results:
            print(f"User at ({result.position_x}, {result.position_y}) from Database {result.database_id}")
        time2 = time.time()
        elapsed_time1 = time2 - time1
        print(f"程序运行时间: {elapsed_time1:.6f} 秒")
        # test2,非加密反向最近邻
        results = federated_query.anti_nearest_query(100, 100)
        print(f"Query Type: AntiNearest, X:100, Y:100")
        for result in results:
            print(f"User at ({result.position_x}, {result.position_y}) from Database {result.database_id}")
        time3 = time.time()
        elapsed_time2 = time3 - time2
        print(f"程序运行时间: {elapsed_time2:.6f} 秒")
        # test3,加密最近邻
        results = federated_query.encrypted_nearest_query(150, 150, 10)
        print(f"Query Type: EncryptedNearest, X:150, Y:150, QueryNum:10")
        for result in results:
            print(f"User at ({result[0]}, {result[1]}) from Database {result[2]}")
        time4 = time.time()
        elapsed_time3 = time4 - time3
        print(f"程序运行时间: {elapsed_time3:.6f} 秒")


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    servicer = FederationServiceServicer(federated_config)
    federation_pb2_grpc.add_FederationServiceServicer_to_server(servicer, server)
    server.add_insecure_port('[::]:50051')
    print("Server is running on port 50051...")
    server.start()
    # 运行测试
    # servicer.test()
    server.wait_for_termination()


if __name__ == '__main__':
    serve()
