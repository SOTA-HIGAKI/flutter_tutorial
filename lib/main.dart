import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_first_app/todo/todo_main.dart';
// import 'package:flutter_first_app/todo/todo_repository.dart';
import 'package:flutter_first_app/widget_table.dart';

void main() {
  // 初期化はこれでもいける
  // WidgetsFlutterBinding.ensureInitialized();
  // final TodoRepository _repo = TodoRepository();
  // await _repo.load();
  runApp(const WidgetApp());
}
