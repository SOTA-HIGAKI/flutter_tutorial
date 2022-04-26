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

  Future<void> add(bool done, String title, String explanation) async {
    int id = getTodoNum() == 0 ? 1 : _list.last.id + 1;
    String dateTime = getDateTIme();
    Map todoMap =
        Todo(id, title, explanation, done, dateTime, dateTime).toJson();
    final Response response = await dio.post('/api/todos/', data: todoMap);
    _list.add(Todo.fromJson(response.data));
  }

  Future update(Todo todo, bool done,
      [String? title, String? explanation]) async {
    todo.done = done;
    if (title != null) {
      todo.title = title;
    }
    if (explanation != null) {
      todo.explanation = explanation;
    }
    todo.updatedDate = getDateTIme();
    final Response response =
        await dio.put('/api/todos/${todo.id}/', data: todo.toJson());
    _list.remove(todo);
    _list.add(Todo.fromJson(response.data));
  }

  Future<void> delete(int id) async {
    // deleteは２０４なんでresponseを返さない
    await dio.delete('/api/todos/$id/');
    _list.removeWhere((element) => element.id == id);
  }

  // todo を読み込み
  Future<void> load() async {
    await _prepareDio(dio);
    final res = await dio.get('/api/todos/');
    List<dynamic> data = res.data;
    _list = data.map((todo) => Todo.fromJson(todo)).toList();
  }

  Future<void> _prepareDio(Dio dio) async {
    dio.options.baseUrl = _uriHost.toString();
  }
}
