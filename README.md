# FederatedDataBase

## 项目简介

科研课堂的大作业,是一个基于gRPC通信实现的具有一定加密功能的联邦数据库,
可以对指定数据进行最近邻查询

## 项目结构

### 后端

后端要求实现`FederatedServer.py`,`DatabaseServer.py`两个程序

分别实现**联邦数据库的服务端**以及每个独立的**数据库本体**

客户端发送查询的数据请求,服务端使用`Flask`服务接收后发送查询操作给服务端管控下的数据库,

数据库在本地查询后,用同态加密算法与其它数据库进行比较,最后返回给服务端唯一的结果

由此防止因泄露数据过多导致的安全性降低

服务端再将结果返回给客户

### 前端
基于`Flutter`框架进行搭建,要求使用gRPC服务实现通信,可自行学习Dart如何配置gRPC
#### ToDo List
1. 主页面设计

   一个封面,标题为"基于gRPC的联邦数据库",下方一个按钮,开始查询

2. 查询页面设计

   主要部分要求使用者填一个表,如`Check`信道所示,填表后点击按钮开始查询,进入结果页面
   查询页面的侧边栏显示与当前联邦数据库链接的所有小型数据库服务器的地址,同时下方设按钮"添加数据库",见信道`Add`

3. 查询结果页面

   设计适当的容器显示查询结果,下设按钮"生成地图",展示一张以查询点为中心,其他点根据坐标分布在不同位置的地图,其中来自不同数据库的数据用不同颜色区分

   可能使用信道`Map`让后端生成图片

4. 实现信道`Check`,要求传入一个如下的message
   ```protobuf
   enum QueryType {
        Nearest = 0;
        AntiNearest = 1;
   }
   message CheckRequest {
       QueryType query_type = 1;     // 查询类型的枚举,包括最近邻查询Nearest和反向最近邻查询AntiNearest
       int32 position_x = 2;         // 待查点的横坐标
       int32 position_y = 3;         // 待查点的纵坐标
       int32 query_num = 4;          // 查询条数,最多为20,当query_type为反向最近邻时无需设置查询条数
       bool encrypt = 5;             // 布尔型变量,表示是否加密,当query_type为反向最近邻时仅支持非加密查询
   }
   ```
   后端返回一个容量为query_num的message,如下

   ```protobuf
   message CheckResult {
       int32 position_x = 1;
       int32 position_y = 2;
       int32 database_id = 3;
   }
   
   message CheckResponse {
       repeated CheckResult results = 1;
   }
   ```

5. 信道`AddDatabase`
   传入表示数据库服务器地址的字符串,后端返回Success或Fail
   ```protobuf
   message AddRequest {
       string address = 1;
   }
   
   enum AddResult {
       Fail = 0;
       Success = 1;
   }
   
   message AddResponse {
       AddResult add_result = 1;
   }
   ```
6. 信道`GenerateMap`
   传入查询结果列表,返回坐标图
   ```protobuf
   message MapResponse {
       bytes map = 1;      // 序列化后的图片的二进制流,前端需要复原成图片
   }
   ```
7. 定义服务`FederatedService`
   ```protobuf
   service FederatedService {
       rpc Check (CheckRequest) returns (CheckResponse);
       rpc AddDatabase (AddRequest) returns (AddResponse);
       rpc GenerateMap (CheckResponse) returns (MapResponse);
   }
   ```
   将protobuf文件命名为`check.proto`,注意编写完成后使用grpcio-tools构建生成`pb2`和`pb2_grpc`文件

   然后在自己的程序中引用这两个文件实现功能,可以参照`FederatedQuery.py`和`DatabaseServer.py`两个文件进行构建

## 项目依赖

运行前安装`flask`,`grpcio`,`tenseal`等软件包进行开发
```
pip install flask grpcio grpcio-tools tenseal numpy
```

## 项目运行

先运行`database.py`
```shell
python DatabaseServer.py
```
再运行`server.py`
```shell
python FederatedQuery.py
```

## 目前的问题
1. 如何添加噪声,使得当需要比较大小的场景中保持信息的隐秘性

2. 设计数据库服务器之间通信的信道,使之可以传输加密工具和加密数据

3. 编写数据生成脚本,当一个数据库的所有数据生成完成后,计算每个点相邻最近点的距离并上传,便于查找反向最近邻

### 剩下的想到了再写吧