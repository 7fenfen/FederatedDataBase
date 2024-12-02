import tenseal as ts

# ======= 第一方 =======
# Step 1: 第一方创建加密环境并生成公钥和私钥
context = ts.context(
    ts.SCHEME_TYPE.CKKS,
    poly_modulus_degree=16384,
    coeff_mod_bit_sizes=[60, 40, 40, 60]
)
context.generate_galois_keys()
context.global_scale = 2 ** 40

# 序列化整个加密上下文（包括公钥和私钥）
serialized_context = context.serialize()

v1 = [0, 1, 2, 3, 4]
enc_v1 = ts.ckks_vector(context, v1)
serialized_enc_v1 = enc_v1.serialize()

# 模拟发送加密上下文和加密数据到第二方
data_sent_to_second_party = {
    "serialized_context": serialized_context,
    "encrypted_data": serialized_enc_v1,
}

# ======= 第二方 =======
# Step 2: 第二方接收到加密上下文和加密数据
received_serialized_context = data_sent_to_second_party["serialized_context"]
received_encrypted_data_v1 = data_sent_to_second_party["encrypted_data"]

# Step 3: 第二方反序列化加密上下文，加载公钥和私钥
second_party_context = ts.context_from(received_serialized_context)

# Step 4: 第二方反序列化加密数据并加载到新的加密环境
enc_v1_second_party = ts.ckks_vector_from(second_party_context, received_encrypted_data_v1)

# 第二方加密自己的数据
v2 = [4, 3, 2, 1, 0]
enc_v2 = ts.ckks_vector(second_party_context, v2)

# 第二方在加密空间内进行加法操作
result = enc_v1_second_party + enc_v2

# 序列化加密的结果以发送回第一方
serialized_result = result.serialize()

# ======= 第一方 =======
# Step 5: 第一方接收到加密的结果并解密
received_result = serialized_result
encrypted_result = ts.ckks_vector_from(context, received_result)

# 解密并输出结果
decrypted_result = encrypted_result.decrypt()
print("Decrypted result of addition:", decrypted_result)
