import grpc
import time
import federation_pb2
import federation_pb2_grpc


# 测试联邦的CheckData方法
def check_test():
    max_msg_size = 100 * 1024 * 1024  # 设置为 100MB
    msg_options = [
        ('grpc.max_send_message_length', max_msg_size),
        ('grpc.max_receive_message_length', max_msg_size),
    ]

    # 建立与联邦端的信道
    federation_stub = federation_pb2_grpc.FederationServiceStub(
        grpc.insecure_channel("localhost:50051", msg_options))

    # test1,非加密最近邻
    time1 = time.time()
    response = federation_stub.CheckData(
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
    elapsed_time1 = time2 - time1
    print(f"程序运行时间: {elapsed_time1:.6f} 秒")
    # test2,非加密反向最近邻
    response = federation_stub.CheckData(
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
    time3 = time.time()
    elapsed_time2 = time3 - time2
    print(f"程序运行时间: {elapsed_time2:.6f} 秒")
    # test3,加密最近邻
    response = federation_stub.CheckData(
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
    time4 = time.time()
    elapsed_time3 = time4 - time3
    print(f"程序运行时间: {elapsed_time3:.6f} 秒")


# 测试联邦的AddDatabase方法
def add_test():
    max_msg_size = 100 * 1024 * 1024  # 设置为 100MB
    msg_options = [
        ('grpc.max_send_message_length', max_msg_size),
        ('grpc.max_receive_message_length', max_msg_size),
    ]

    # 建立与联邦端的信道
    federation_stub = federation_pb2_grpc.FederationServiceStub(
        grpc.insecure_channel("localhost:50051", msg_options))

    result = federation_stub.AddDatabase(federation_pb2.AddRequest(
        address="localhost:60054",
    ))
    print(result.add_result)


if __name__ == '__main__':
    check_test()
    add_test()
