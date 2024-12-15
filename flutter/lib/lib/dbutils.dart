import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void saveDb(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

// 保存列表到 SharedPreferences，专为json数据设计
Future<void> saveDbList(String key, List<String> value) async {
  try {
    // 获取 SharedPreferences 实例
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 将 List<String> 转换为 JSON 字符串
    String jsonString = jsonEncode(value);

    // 将 JSON 字符串保存到 SharedPreferences
    await prefs.setString(key, jsonString);
  } catch (e) {
    // 捕获并处理异常
    print('Error saving db list: $e');
  }
}

Future<String> getDb(String key) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    if (value == null) {
      return '';
    }
    return value;
  } catch (e) {
    return '';
  }
}

// 从 SharedPreferences 获取列表数据，转为 Dart 列表，专为json数据设计
Future<List<String>> getDbList(String key) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    if (value == null) {
      return [];
    }
    // 将 JSON 字符串解析为 Dart 列表
    List<dynamic> dynamicList = jsonDecode(value);
    // 将动态列表转换为 List<String>
    List<String> stringList = dynamicList.cast<String>();

    return stringList;
  } catch (e) {
    return [];
  }
}

void removeDb(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}
