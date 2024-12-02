import grpc
from DataBase import query_pb2, query_pb2_grpc


class FederatedQuery:
    def __init__(self, addresses):
        self.addresses = addresses
        self.small_databases = self.stub_init()

    def stub_init(self):
        stubs = []
        for address in self.addresses:
            channel = grpc.insecure_channel(address)
            stubs.append(query_pb2_grpc.FederatedDatabaseServiceStub(channel))

        return stubs

    def query(self, query_type, query_x, query_y, query_num):
        distances = []

        # 向每个小型数据库发送查询请求，获取k个点的距离
        for db_stub in self.small_databases:
            response = db_stub.QueryDistance(
                query_pb2.QueryRequest(
                    type=query_type,
                    position_x=query_x,
                    position_y=query_y,
                    query_num=query_num))
            # 将返回的距离加入列表
            for dis_result in response.results:
                distances.append((dis_result.distance, db_stub))

        # 根据距离排序，选择最接近的k个点
        distances.sort(key=lambda x: x[0])
        nearest_results = distances[:query_num]

        # 计算每个数据库应该返回多少个点
        db_counts = {db_stub: 0 for db_stub in self.small_databases}
        for _, db_stub in nearest_results:
            db_counts[db_stub] += 1

        # 向小型数据库发送请求，请求返回相应数量的点
        final_results = []
        for db_stub, count in db_counts.items():
            if count > 0:
                response = db_stub.QueryNeedNum(query_pb2.NumRequest(need_num=count))
                final_results.extend(response.results)

        return final_results


def run():
    federated_query = FederatedQuery(["localhost:50051", "localhost:50052", "localhost:50053"])

    # 设置查询点位置和需要查询的最近k个点
    query_type = query_pb2.Nearest

    # 查询并返回最接近的k个点
    # test1
    results = federated_query.query(query_type, 50, 50, 5)
    print(f"Query Type: {query_type}, X:50, Y:50, QueryNum:5")
    for result in results:
        print(f"User at ({result.position_x}, {result.position_y}) from Database {result.database_id}")
    # test2
    results = federated_query.query(query_type, 50, 50, 10)
    print(f"Query Type: {query_type}, X:50, Y:50, QueryNum:10")
    for result in results:
        print(f"User at ({result.position_x}, {result.position_y}) from Database {result.database_id}")
    # test3
    results = federated_query.query(query_type, 30, 30, 5)
    print(f"Query Type: {query_type}, X:30, Y:30, QueryNum:5")
    for result in results:
        print(f"User at ({result.position_x}, {result.position_y}) from Database {result.database_id}")


if __name__ == '__main__':
    run()
