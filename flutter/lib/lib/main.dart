import 'package:flutter/material.dart';
import 'package:federateddatabaseflutter/generated/federation.pb.dart';
import 'package:federateddatabaseflutter/generated/federation.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'dbutils.dart';

// protoc文件编译命令
// protoc --dart_out=grpc:lib/generated -Iprotos protos/federation.proto

// flutter windows app编译命令
// flutter build windows

// 用于校验数据库地址(addDatabase)的异步函数
Future<int> addDatabase(String newDatabase) async {
  final channel = ClientChannel('127.0.0.1',
      port: 50051,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ));

  final stub = FederationServiceClient(channel);

  try {
    AddRequest request = AddRequest()..address = newDatabase;
    AddResponse response = await stub.addDatabase(request);

    if (response.addResult == AddResult.Success) {
      return 1;
    } else {
      return 0;
    }
  } catch (e) {
    print('Caught error: $e');
    return -1;
  } finally {
    await channel.shutdown();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Federated Data Base',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'DengXian', // 设置全局字体
      ),
      home: const MainPage(title: '基于gRPC的联邦数据库'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DataBasePage(title: '数据库'),
    const SearchPage(title: '数据查询'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('查询'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.purple,
        // 选中项的颜色
        unselectedItemColor: Colors.grey,
        // 未选中项的颜色
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.data_array),
            label: '数据库',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '数据查询',
          ),
        ],
      ),
    );
  }
}

class DataBasePage extends StatefulWidget {
  const DataBasePage({super.key, required this.title});

  final String title;

  @override
  State<DataBasePage> createState() => _DataBasePageState();
}

class _DataBasePageState extends State<DataBasePage> {
  List<String> databases = [];

  @override
  void initState() {
    super.initState();
    _loadDatabases();
  }

  Future<void> _loadDatabases() async {
    List<String> dbList = await getDbList('databases');
    if (dbList.isEmpty) {
      dbList = ['127.0.0.1:60051', '127.0.0.1:60052']; //, 127.0.0.1:60053
      await saveDbList('databases', dbList);
    }
    dbList = await getDbList('databases');
    setState(() {
      databases = dbList;
    });
  }

  void _showAddDatabaseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newDatabase = '';
        return AlertDialog(
          title: const Text('添加数据库'),
          content: TextField(
            onChanged: (value) {
              newDatabase = value;
            },
            decoration: const InputDecoration(hintText: '数据库地址'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('确定'),
              onPressed: () async {
                // 一个不可取消的对话框
                showDialog(
                  context: context,
                  barrierDismissible: false, // 点击外部区域不会关闭对话框
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      title: Text('提示'),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '正在校验...',
                            style: TextStyle(fontSize: 16), // 可以根据需要调整字体大小
                          ),
                          SizedBox(width: 25), // 添加间距
                          SizedBox(
                            width: 32, // 设置宽度
                            height: 32, // 设置高度，确保纵横比为1:1
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                      actions: <Widget>[],
                    );
                  },
                );

                // 校验数据库地址并处理结果
                int addResult = await addDatabase(newDatabase);

                // 关闭“正在校验...”的对话框
                Navigator.of(context).pop();

                if (newDatabase.isNotEmpty) {
                  if (addResult == 1) {
                    databases.add(newDatabase);
                    await saveDbList('databases', databases);
                    setState(() {});
                    Navigator.of(context).pop();
                  } else {
                    String message = '未知错误';
                    if (addResult == 0) message = '数据库校验不通过，请检查数据库地址';
                    if (addResult == -1) message = '数据库服务器错误，请检查网络连接';

                    // 显示错误信息对话框
                    _showErrorDialog(message);
                  }
                } else {
                  print('数据库地址不能为空');
                  _showErrorDialog('数据库地址不能为空');
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('提示'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('确定'),
              onPressed: () {
                Navigator.of(context).pop(); // 关闭对话框
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteDatabase(int index) async {
    databases.removeAt(index);
    await saveDbList('databases', databases);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _showAddDatabaseDialog,
          child: const Text('添加数据库'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: databases.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.data_object),
                title: Text(databases[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteDatabase(index);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String queryType = 'Nearest';
  TextEditingController xController = TextEditingController();
  TextEditingController yController = TextEditingController();
  String queryNum = '1';
  String encrypt = '加密';
  List<CheckResult> results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('数据查询',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildDropdownField('查询类型', queryType, ['Nearest', 'AntiNearest'],
                (value) {
              setState(() => queryType = value!);
            }),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildTextField('x', xController)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('y', yController)),
              ],
            ),
            const SizedBox(height: 16),
            _buildDropdownField('查询条数', queryNum,
                List.generate(20, (index) => (index + 1).toString()), (value) {
              setState(() => queryNum = value!);
            }),
            const SizedBox(height: 16),
            _buildDropdownField('是否加密', encrypt, ['加密', '不加密'], (value) {
              setState(() => encrypt = value!);
            }),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _submitQuery,
                child: const Text('提交查询'),
              ),
            ),
            const Divider(height: 32),
            const Text('查询结果',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...results.map((result) => _buildResultItem(result)).toList(),
          ],
        ),
      ),
    );
  }

  // 下拉框
  Widget _buildDropdownField(String hint, String value, List<String> items,
      Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: hint,
      ),
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  // 文本框
  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: hint,
      ),
      keyboardType: TextInputType.number,
    );
  }

  // 查询结果（自定义列表视图）
  Widget _buildResultItem(CheckResult result) {
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: 'X: ',
                style: const TextStyle(color: Colors.black), // 默认颜色
                children: <TextSpan>[
                  TextSpan(
                    text: '${result.positionX}',
                    style: const TextStyle(fontWeight: FontWeight.bold), // 加粗值
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Y: ',
                style: const TextStyle(color: Colors.black), // 默认颜色
                children: <TextSpan>[
                  TextSpan(
                    text: '${result.positionY}',
                    style: const TextStyle(fontWeight: FontWeight.bold), // 加粗值
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Database ID: ',
                style: const TextStyle(color: Colors.black), // 默认颜色
                children: <TextSpan>[
                  TextSpan(
                    text: '${result.databaseId}',
                    style: const TextStyle(fontWeight: FontWeight.bold), // 加粗值
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }

  //查询函数，异步进行
  void _submitQuery() async {
    if (!_validateInputs()) return;

    //TODO 显示一个易等待的查询进度条
    // 显示正在查询的对话框
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('提示'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('正在查询...', style: TextStyle(fontSize: 16)),
              SizedBox(width: 25),
              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        );
      },
    );

    try {
      final channel = ClientChannel('127.0.0.1',
          port: 50051,
          options: ChannelOptions(
            credentials: const ChannelCredentials.insecure(),
            codecRegistry: CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
            idleTimeout: const Duration(minutes: 2),
          ));

      final stub = FederationServiceClient(channel,
          options: CallOptions(timeout: const Duration(seconds: 60)));

      final request = CheckRequest()
        ..queryType =
            queryType == 'Nearest' ? QueryType.Nearest : QueryType.AntiNearest
        ..positionX = int.parse(xController.text)
        ..positionY = int.parse(yController.text)
        ..queryNum = int.parse(queryNum)
        ..encrypt = encrypt == '加密';

      final response = await stub.checkData(request);


      setState(() {
        results = response.results;
      });

      await channel.shutdown();
    } catch (e) {
      print('Error: $e');
    } finally {
      Navigator.of(context).pop();
    }
  }

  bool _validateInputs() {
    if (xController.text.isEmpty || yController.text.isEmpty) {
      _showErrorDialog('请输入x和y坐标');
      return false;
    }
    if (int.tryParse(xController.text) == null ||
        int.tryParse(yController.text) == null) {
      _showErrorDialog('x和y坐标必须为整数');
      return false;
    }
    if (queryType == 'AntiNearest' && encrypt == '加密') {
      _showErrorDialog('反向最近邻查询不支持加密');
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('错误'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 居中对齐
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // 导航到新页面
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: const Text('开始查询'),
            ),
          ],
        ),
      ),
    );
  }
}
