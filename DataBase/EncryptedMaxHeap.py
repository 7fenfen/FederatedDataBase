import grpc
from DataBase import federation_pb2, federation_pb2_grpc


max_msg_size = 100 * 1024 * 1024  # 设置为 100MB
msg_options = [
    ('grpc.max_send_message_length', max_msg_size),
    ('grpc.max_receive_message_length', max_msg_size),
]

# 建立与联邦端的信道
federation_stub = federation_pb2_grpc.FederationServiceStub(
    grpc.insecure_channel("localhost:50051", msg_options))


def encrypt_compare(item1, item2):
    # x1>x2返回1
    dis_diff = item1[0] - item2[0]
    result = federation_stub.CompareDist(
        federation_pb2.DistDiff(
            dis_diff=dis_diff.serialize()
        )
    )
    if result.cmp_result == 1:
        return 1
    elif result.cmp_result == -1:
        return -1
    else:
        return 0


class EncryptedMaxHeap:
    def __init__(self, capacity):
        self.heap = []  # 堆数组
        self.capacity = capacity

    def push(self, value):
        """将新元素插入堆中"""
        if len(self.heap) < self.capacity:
            self.heap.append(value)
            self._heapify_up(len(self.heap) - 1)  # 上浮调整
        else:
            # 堆已满，比较新元素与堆顶元素
            top = self.heap[0]
            if encrypt_compare(value, top) == -1:  # value < top，替换堆顶元素
                self.heap[0] = value
                self._heapify_down(0)  # 下沉调整

    def _heapify_up(self, index):
        """上浮操作：确保堆的性质"""
        while index > 0:
            parent = (index - 1) // 2
            if encrypt_compare(self.heap[index], self.heap[parent]) == 1:  # 子节点 > 父节点
                self.heap[index], self.heap[parent] = self.heap[parent], self.heap[index]
                index = parent
            else:
                break

    def _heapify_down(self, index):
        """下沉操作：确保堆的性质"""
        size = len(self.heap)
        while True:
            left = 2 * index + 1
            right = 2 * index + 2
            largest = index

            # 找出左右子节点中最大的节点
            if left < size and encrypt_compare(self.heap[left], self.heap[largest]) == 1:
                largest = left
            if right < size and encrypt_compare(self.heap[right], self.heap[largest]) == 1:
                largest = right

            if largest != index:
                self.heap[index], self.heap[largest] = self.heap[largest], self.heap[index]
                index = largest
            else:
                break

    def get_elements(self):
        """返回堆中的元素"""
        return self.heap

