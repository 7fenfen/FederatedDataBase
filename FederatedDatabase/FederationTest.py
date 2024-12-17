import grpc
import time
import federation_pb2
import federation_pb2_grpc


class FederationTest:
    def __init__(self):
        max_msg_size = 100 * 1024 * 1024  # 设置为 100MB
        msg_options = [
            ('grpc.max_send_message_length', max_msg_size),
            ('grpc.max_receive_message_length', max_msg_size),
        ]

        # 建立与联邦端的信道
        self.federation_stub = federation_pb2_grpc.FederationServiceStub(
            grpc.insecure_channel("localhost:50051", msg_options))

    # 测试联邦的CheckData方法
    def nearest_test(self):

        # test1,非加密最近邻
        time1 = time.time()
        response = self.federation_stub.CheckData(
            federation_pb2.CheckRequest(
                query_type=federation_pb2.Nearest,
                position_x=150,
                position_y=150,
                query_num=10,
                encrypt=False
            ))
        print(f"Query Type: Nearest, X:150, Y:150, QueryNum:10")
        for result in response.results:
            print(f"User at ({result.position_x}, {result.position_y}) from Database {result.database_id}")
        time2 = time.time()
        elapsed_time = time2 - time1
        print(f"程序运行时间: {elapsed_time:.6f} 秒")

    def anti_nearset_test(self):

        # test2,非加密反向最近邻
        time1 = time.time()
        response = self.federation_stub.CheckData(
            federation_pb2.CheckRequest(
                query_type=federation_pb2.AntiNearest,
                position_x=150,
                position_y=50,
                query_num=10,  # 不影响
                encrypt=False
            ))
        print(f"Query Type: AntiNearest, X:150, Y:50")
        for result in response.results:
            print(f"User at ({result.position_x}, {result.position_y}) from Database {result.database_id}")
        time2 = time.time()
        elapsed_time = time2 - time1
        print(f"程序运行时间: {elapsed_time:.6f} 秒")

    def encrypted_nearset_test(self):

        # test3,加密最近邻
        time1 = time.time()
        response = self.federation_stub.CheckData(
            federation_pb2.CheckRequest(
                query_type=federation_pb2.Nearest,
                position_x=150,
                position_y=150,
                query_num=10,
                encrypt=True
            ))
        print(f"Query Type: EncryptedNearest, X:150, Y:150, QueryNum:10")
        for result in response.results:
            print(f"User at ({result.position_x}, {result.position_y}) from Database {result.database_id}")
        time2 = time.time()
        elapsed_time = time2 - time1
        print(f"程序运行时间: {elapsed_time:.6f} 秒")

    # 测试联邦的AddDatabase方法
    def add_test(self):
        result = self.federation_stub.AddDatabase(federation_pb2.AddRequest(
            address="localhost:60054",
        ))
        print(result.add_result)


if __name__ == '__main__':
    tester = FederationTest()
    tester.nearest_test()
    tester.anti_nearset_test()
    tester.encrypted_nearset_test()
