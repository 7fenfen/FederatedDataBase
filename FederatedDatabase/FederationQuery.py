import grpc
import database_pb2, database_pb2_grpc
import tenseal as ts


class FederationQuery:
    def __init__(self, addresses, context):
        self.addresses = addresses
        self.small_databases = self.stub_init()
        self.context = context

    def stub_init(self):
        stubs = []
        max_msg_size = 100 * 1024 * 1024  # 设置为 100MB
        options = [
            ('grpc.max_send_message_length', max_msg_size),
            ('grpc.max_receive_message_length', max_msg_size),
        ]
        for address in self.addresses:
            channel = grpc.insecure_channel(address, options=options)
            stubs.append(database_pb2_grpc.DatabaseServiceStub(channel))

        return stubs

    def nearest_query(self, query_x, query_y, query_num):
        distances = []

        # 向每个小型数据库发送查询请求，获取k个点的距离
        for db_stub in self.small_databases:
            response = db_stub.QueryDistance(
                database_pb2.NearestQueryRequest(
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
                response = db_stub.QueryNeedNum(database_pb2.NumRequest(need_num=count))
                final_results.extend(response.results)

        return final_results

    def anti_nearest_query(self, query_x, query_y):
        final_results = []
        # 向每个小型数据库发送查询请求，获取全部的以所查点为最近邻的点
        for db_stub in self.small_databases:
            response = db_stub.AntiNearestQuery(
                database_pb2.AntiNearestQueryRequest(
                    position_x=query_x,
                    position_y=query_y))
            final_results.extend(response.results)
        return final_results

    def encrypted_nearest_query(self, query_x, query_y, query_num):
        # 序列化加密环境
        serialized_context = self.context.serialize()
        # 加密数据
        enc_query_x = ts.ckks_vector(self.context, query_x).serialize()
        enc_query_y = ts.ckks_vector(self.context, query_y).serialize()

        # 创建结果列表
        distances = []

        # 向每个小型数据库发送查询请求，获取k个点的距离
        for db_stub in self.small_databases:
            response = db_stub.EncryptedQueryDistance(
                database_pb2.EncryptedNearestQueryRequest(
                    context=serialized_context,  # 二进制流
                    position_x=enc_query_x,
                    position_y=enc_query_y,
                    query_num=query_num))
            for dis_result in response.results:
                # 将序列化的结果变成密文并解密
                dec_dis_result = ts.ckks_vector_from(self.context, dis_result.distance).decrypt()
                # 将返回的距离加入列表
                distances.append((dec_dis_result, db_stub))

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
                response = db_stub.QueryNeedNum(database_pb2.NumRequest(need_num=count))
                for result in response.results:
                    # 将序列化的结果变成密文并解密
                    dec_position_x = ts.ckks_vector_from(self.context, result.position_x).decrypt()
                    dec_position_y = ts.ckks_vector_from(self.context, result.position_y).decrypt()
                    # 将最终结果加入列表
                    final_results = [].append((dec_position_x, dec_position_y, result.database_id))
        return final_results


def test():
    context = ts.context(
            ts.SCHEME_TYPE.CKKS,
            poly_modulus_degree=16384,
            coeff_mod_bit_sizes=[60, 40, 40, 60]
        )
    context.generate_galois_keys()
    context.global_scale = 2 ** 40
    federated_query = FederationQuery(["localhost:60051", "localhost:60052", "localhost:60053"], context)

    # test1,非加密最近邻
    results = federated_query.nearest_query(150, 150, 5)
    print(f"Query Type: Nearest, X:150, Y:150, QueryNum:5")
    for result in results:
        print(f"User at ({result.position_x}, {result.position_y}) from Database {result.database_id}")
    # test2,非加密反向最近邻
    results = federated_query.anti_nearest_query(50, 50)
    print(f"Query Type: AntiNearest, X:50, Y:50")
    for result in results:
        print(f"User at ({result.position_x}, {result.position_y}) from Database {result.database_id}")


if __name__ == '__main__':
    test()
