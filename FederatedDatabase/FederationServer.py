import grpc
import json
from concurrent import futures
import database_pb2
import database_pb2_grpc
import federation_pb2
import federation_pb2_grpc
import mysql.connector
from mysql.connector import Error
from FederationQuery import FederationQuery

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
        self.querier = FederationQuery(self.database_address)

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

    def Check(self, request, context):
        """处理Check请求"""
        # TODO: 实现函数逻辑
        return federation_pb2.CheckResponse()

    def AddDatabase(self, request, context):
        """处理AddDatabase请求"""
        # TODO: 实现函数逻辑
        return federation_pb2.AddResponse()

    def GenerateMap(self, request, context):
        """处理GenerateMap请求"""
        # TODO: 实现函数逻辑
        return federation_pb2.MapResponse()


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    federation_pb2_grpc.add_FederationServiceServicer_to_server(FederationServiceServicer(federated_config), server)
    server.add_insecure_port('[::]:50051')
    print("Server is running on port 50051...")
    server.start()
    server.wait_for_termination()


if __name__ == '__main__':
    serve()
