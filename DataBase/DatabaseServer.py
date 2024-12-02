import grpc
from concurrent import futures  # 修改为正确的导入方式
from google.protobuf import empty_pb2
import query_pb2
import query_pb2_grpc
from threading import Thread
import random
import math


class FederatedDatabaseServiceServicer(query_pb2_grpc.FederatedDatabaseServiceServicer):
    def __init__(self, database_id, data_size=100):
        self.database_id = database_id
        # 模拟数据库内的点 (user_id, position_x, position_y)
        self.data = [(i, random.randint(0, 100), random.randint(0, 100)) for i in range(data_size)]
        self.distances = []  # 用来存储到查询点的距离（第一次查询时计算）

    def calculate_distance(self, x1, y1, x2, y2):
        return math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2)

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
        nearest_distances = [query_pb2.DisResult(
            distance=distance)
            for distance, _, _, _ in self.distances[:query_num]]

        return query_pb2.DisResponse(results=nearest_distances)

    def QueryNeedNum(self, request, context):
        num_points = request.need_num

        # 直接根据已排序的距离列表返回最接近的num_points个点
        nearest_points = self.distances[:num_points]

        # 使用通用格式化函数构造返回结果
        results = [
            query_pb2.QueryResult(
                position_x=x,
                position_y=y,
                database_id=self.database_id
            )
            for _, _, x, y in nearest_points
        ]

        # 清空 distances，以便下一次查询时可以重新计算
        self.distances = []

        return query_pb2.QueryResponse(results=results)


def serve(database_id, port, data_size):
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    # 添加查询服务
    query_pb2_grpc.add_FederatedDatabaseServiceServicer_to_server(
        FederatedDatabaseServiceServicer(database_id, data_size), server)
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
