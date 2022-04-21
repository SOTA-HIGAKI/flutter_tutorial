import 'package:flutter/material.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "todo app",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('todo list'),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(title: Text(todoList[index])),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newListText = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return const TodoAddPage();
          }));
          if (newListText != null) {
            setState(() {
              todoList.add(newListText);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoAddPage extends StatefulWidget {
  const TodoAddPage({Key? key}) : super(key: key);

  @override
  State<TodoAddPage> createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 余白を付ける
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // テキスト入力
            Text(
              _text,
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(onChanged: (String value) {
              setState(() {
                _text = value;
              });
            }),
            const SizedBox(height: 8),
            SizedBox(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // リスト追加ボタン
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(_text);
                },
                child:
                    const Text('リスト追加', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // キャンセルボタン
              child: TextButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: const Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
