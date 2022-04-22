import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'todo.dart';

class TodoRepository {
  final String _saveKey = "Todo";
  List<Todo> _list = [];

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

  Future<void> add(bool done, String title, String detail) async {
    int id = getTodoNum() == 0 ? 1 : _list.last.id + 1;
    String dateTime = getDateTIme();
    Todo todo = Todo(id, title, detail, done, dateTime, dateTime);
    _list.add(todo);
    await save();
  }

  Future<void> update(Todo todo, bool done,
      [String? title, String? detail]) async {
    todo.done = done;
    if (title != null) {
      todo.title = title;
    }
    if (detail != null) {
      todo.detail = detail;
    }
    todo.updateDate = getDateTIme();
    await save();
  }

  Future<void> delete(Todo todo) async {
    _list.remove(todo);
    await save();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    var saveTargetList = _list.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(_saveKey, saveTargetList);
  }

  // todo を読み込み
  Future<void> load() async {
    print("load");
    print(await SharedPreferences.getInstance());
    var prefs = await SharedPreferences.getInstance();
    print("after declaring prefs");
    print(prefs);
    var loadTargetList = prefs.getStringList(_saveKey) ?? [];
    print("loadTargetList");
    print(loadTargetList);
    _list = loadTargetList.map((e) => Todo.fromJson(json.decode(e))).toList();
  }
}
