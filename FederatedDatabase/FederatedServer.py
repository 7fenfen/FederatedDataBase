import grpc
import json
from concurrent import futures
import query_pb2
import query_pb2_grpc
import check_pb2
import check_pb2_grpc
import mysql.connector
from mysql.connector import Error

config = {
    'host': '112.4.115.127',
    'port': 3312,
    'database': 'zhx_0001',
    'user': 'zhx_0001',
    'password': 'ARfDhjdBbBmzrMaY'
}


class FederatedServiceServicer(check_pb2_grpc.FederatedServiceServicer):
    def __init__(self, config):
        try:
            # 初始化连接和游标
            self.connection = mysql.connector.connect(**config)
            self.cursor = self.connection.cursor()
            print('Connection successful')
            self.database_address = self.get_database_address()
        except Error as e:
            print("Error while connecting to MySQL", e)

    def get_database_address(self):
        try:
            # 定义参数化查询
            query = "SELECT database_address FROM address"
            # 执行查询
            self.cursor.execute(query)
            # 获取查询结果
            records = self.cursor.fetchall()
            # 将查询结果转换为JSON数组
            json_result = json.loads(records[0][0])
            # 返回JSON 结果
            return json_result

        except Error as e:
            print("Error while connecting to MySQL", e)

    def Check(self, request, context):
        """处理Check请求"""
        # TODO: 实现函数逻辑
        return check_pb2.CheckResponse()

    def AddDatabase(self, request, context):
        """处理AddDatabase请求"""
        # TODO: 实现函数逻辑
        return check_pb2.AddResponse()

    def GenerateMap(self, request, context):
        """处理GenerateMap请求"""
        # TODO: 实现函数逻辑
        return check_pb2.MapResponse()


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    check_pb2_grpc.add_FederatedServiceServicer_to_server(FederatedServiceServicer(config), server)
    server.add_insecure_port('[::]:50051')
    print("Server is running on port 50051...")
    server.start()
    server.wait_for_termination()


if __name__ == '__main__':
    serve()
