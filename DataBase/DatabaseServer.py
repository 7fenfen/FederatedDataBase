import grpc
from concurrent import futures
import database_pb2
import database_pb2_grpc
import federation_pb2
import federation_pb2_grpc
from threading import Thread
import random
import math
import tenseal as ts


class DatabaseServiceServicer(database_pb2_grpc.DatabaseServiceServicer):
    def __init__(self, database_id, other_database_address, data_size=100):
        self.database_id = database_id
        self.other_database_address = other_database_address
        self.other_database = self.stub_init()
        self.context = self.create_context()
        # 模拟数据库内的点 (user_id, position_x, position_y)
        self.data = [(i, random.randint(0, 100), random.randint(0, 100)) for i in range(data_size)]
        self.distances = []  # 用来存储到查询点的距离（第一次查询时计算）
        self.enc_distances = []  # 用来存储到查询点的加密距离（第一次查询时计算）
        # 建立与联邦端的信道
        self.stub = federation_pb2_grpc.FederationServiceStub(grpc.insecure_channel("localhost:50051"))

    def stub_init(self):
        stubs = []
        for address in self.other_database_address:
            channel = grpc.insecure_channel(address)
            stubs.append(database_pb2_grpc.DatabaseServiceStub(channel))

        return stubs

    @staticmethod
    def create_context():
        context = ts.context(
            ts.SCHEME_TYPE.CKKS,
            poly_modulus_degree=16384,
            coeff_mod_bit_sizes=[60, 40, 40, 60]
        )
        context.generate_galois_keys()
        context.global_scale = 2 ** 40
        return context

    @staticmethod
    def calculate_distance(x1, y1, x2, y2):
        return (x1 - x2) ** 2 + (y1 - y2) ** 2

    def encrypt_compare(self, x1, x2):
        result = self.stub.CompareDist(
            federation_pb2.DistDiff(
                dis1=x1,
                dis2=x2,
            )
        )
        return result

    def encrypt_sort(self, enc_array):
        n = len(enc_array)
        for i in range(n):
            for j in range(0, n - i - 1):
                # 使用自定义比较函数
                if self.encrypt_compare(enc_array[j][0], enc_array[j + 1][0]) > 0:
                    # 交换位置
                    enc_array[j], enc_array[j + 1] = enc_array[j + 1], enc_array[j]
        return enc_array

    def QueryDistance(self, request, context):
        query_x = request.position_x
        query_y = request.position_y
        query_num = request.query_num

        self.distances = []  # 清空距离数据
        for user_id, x, y in self.data:
            distance = self.calculate_distance(query_x, query_y, x, y)
            self.distances.append((distance, user_id, x, y))

        # 按照距离升序排序
        self.distances.sort(key=lambda x: x[0])

        # 返回前query_num个距离
        nearest_distances = [database_pb2.DisResult(
            distance=distance)
            for distance, _, _, _ in self.distances[:query_num]]

        return database_pb2.DisResponse(results=nearest_distances)

    def QueryNeedNum(self, request, context):
        num_points = request.need_num

        # 直接根据已排序的距离列表返回最接近的num_points个点
        nearest_points = self.distances[:num_points]

        results = [
            database_pb2.QueryResult(
                position_x=x,
                position_y=y,
                database_id=self.database_id
            )
            for _, _, x, y in nearest_points
        ]

        # 清空 distances，以便下一次查询时可以重新计算
        self.distances = []
        return database_pb2.QueryResponse(results=results)

    def AntiNearestQuery(self, request, context):
        temp_result = []
        query_x = request.position_x
        query_y = request.position_y
        # 看有没有以查询点为最小最近邻的点
        for _, x, y, min_dis in self.data:
            dis = self.calculate_distance(query_x, query_y, x, y)
            if dis < min_dis:
                temp_result.append((x, y, dis))
        # 序列化加密环境
        serialized_context = self.context.serialize()
        # 与其它数据库比较
        for item in temp_result:
            # 加密数据
            enc_position_x = ts.ckks_vector(context, item[0])
            enc_position_y = ts.ckks_vector(context, item[1])
            enc_min_dis = item[2]
            # 创建结果列表
            result = []
            for stub in self.other_database:
                response = stub.CompareQuery(
                    database_pb2.CompareOtherDatabase(
                        context=serialized_context,
                        position_x=enc_position_x,
                        position_y=enc_position_y,
                        min_dis=enc_min_dis
                    )
                )
                result.append(response)

    def EncryptedQueryDistance(self, request, context):
        # 接收数据
        received_context = request.context  # 序列化的加密环境
        # 还原加密环境
        database_party_context = ts.context_from(received_context)
        # 把数据加载到新的加密环境
        enc_query_x = ts.ckks_vector_from(database_party_context, request.position_x)
        enc_query_y = ts.ckks_vector_from(database_party_context, request.position_y)
        query_num = request.query_num

        self.enc_distances = []  # 清空距离数据

        for user_id, x, y in self.data:
            # 加密x,y
            enc_x = ts.ckks_vector(database_party_context, x)
            enc_y = ts.ckks_vector(database_party_context, y)
            # 计算距离(加密后)
            distance = self.calculate_distance(enc_query_x, enc_query_y, enc_x, enc_y)
            serialized_distance = distance.serialize()
            # 加入列表
            self.enc_distances.append((serialized_distance, user_id, x, y))

        # 按照距离升序排序
        self.encrypt_sort(self.enc_distances)

        # 返回前query_num个距离
        nearest_distances = [database_pb2.EncryptedDisResult(
            distance=distance)
            for distance, _, _, _ in self.enc_distances[:query_num]]

        return database_pb2.EncryptedDisResponse(results=nearest_distances)

    def EncryptedQueryNeedNum(self, request, context):

    def CompareQuery(self, request, context):


def serve(database_id, port, data_size):
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    # 添加查询服务
    database_pb2_grpc.add_DatabaseServiceServicer_to_server(
        DatabaseServiceServicer(database_id, data_size), server)
    # 监听端口
    server.add_insecure_port(f'[::]:{port}')
    print(f"Server {database_id} started on ports {port} \n")
    server.start()
    server.wait_for_termination()


if __name__ == '__main__':
    # 启动多个服务端
    thread1 = Thread(target=serve, args=(1, 50051, 100))
    thread2 = Thread(target=serve, args=(2, 50052, 100))
    thread3 = Thread(target=serve, args=(3, 50053, 100))

    thread1.start()
    thread2.start()
    thread3.start()

    # 等待线程结束
    thread1.join()
    thread2.join()
    thread3.join()
