import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'todo.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

class TodoRepository {
  final Uri _uriHost = Uri.parse('http://localhost:8000/');
  // final String _saveKey = "Todo";
  List<dynamic> _list = [];
  // bool _isSuccess = false;
  Dio dio = Dio();

  static final TodoRepository _instance = TodoRepository._();

  TodoRepository._();

  factory TodoRepository() {
    return _instance;
  }

  int getTodoNum() {
    return _list.length;
  }

  Todo findByIndex(int index) {
    return _list[index];
  }

  String getDateTIme() {
    var format = DateFormat("yyyy-MM-dd");
    var dateTIme = format.format(DateTime.now());
    return dateTIme;
  }

  Future add(bool done, String title, String explanation) async {
    int id = getTodoNum() == 0 ? 1 : _list.last.id + 1;
    String dateTime = getDateTIme();
    Map todoMap = Todo(id, title, explanation, done, dateTime, dateTime).toJson();
    final Response response = await dio.post('/api/todos/', data: todoMap);

    return response;
  }

  Future update(Todo todo, bool done, [String? title, String? explanation]) async {
    todo.done = done;
    if (title != null) {
      todo.title = title;
    }
    if (explanation != null) {
      todo.explanation = explanation;
    }
    todo.updatedDate = getDateTIme();

    final Response response =
        await dio.post('/api/todos/', data: todo.toJson());

    return response;
  }

  Future delete(int id) async {
    final Response response = await dio.delete('/api/todos/$id/');
    return response;
  }

  // todo を読み込み
  Future<void> load() async {
    await _prepareDio(dio);
    final res = await dio.get('/api/todos/');
    _list = res.data.map((todo) => Todo.fromJson(todo)).toList();
  }

  Future<void> _prepareDio(Dio dio) async {
    dio.options.baseUrl = _uriHost.toString();
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
  }
}
