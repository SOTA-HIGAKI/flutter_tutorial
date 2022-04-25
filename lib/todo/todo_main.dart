import 'package:flutter/material.dart';
import 'package:flutter_first_app/todo/todo.dart';
import 'package:flutter_first_app/todo/todo_repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
  final TodoRepository _repo = TodoRepository();

  void _pushTodoInputPage([Todo? todo]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return TodoAddPage(todo: todo);
        },
      ),
    );
    // // Todoの追加/更新を行う場合があるため、画面を更新する
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // () async {
    //   await _repo.load();
    //   setState(() {});
    // };
    // FutureでラップしないとinitState()が終わってしまう why
    Future<void> (
      () async {
        await _repo.load();
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('todo list'),
      ),
      body: ListView.builder(
        itemCount: _repo.getTodoNum(),
        itemBuilder: (context, index) {
          Todo todo = _repo.findByIndex(index);
          return Slidable(
            startActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.25,
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      _pushTodoInputPage(todo);
                    },
                    backgroundColor: Colors.green,
                    icon: Icons.edit,
                    label: '編集',
                  )
                ]),
            endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.25,
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      await _repo.delete(todo.id);
                      setState(() {});
                    },
                    backgroundColor: Colors.red,
                    icon: Icons.edit,
                    label: '削除',
                  )
                ]),
            child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Colors.grey),
                )),
                child: ListTile(
                    leading: Text(todo.id.toString()),
                    title: Text(todo.title),
                    trailing: Checkbox(
                      value: todo.done,
                      onChanged: (bool? value) async {
                        await _repo.update(todo, value!);
                        setState(() {});
                      },
                    ))),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // push method returns Future object
        onPressed: _pushTodoInputPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoAddPage extends StatefulWidget {
  final Todo? todo;
  const TodoAddPage({Key? key, this.todo}) : super(key: key);

  @override
  State<TodoAddPage> createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  final TodoRepository _repo = TodoRepository();

  // late initialization
  late bool _isCreateTodo;
  late String _title;
  late String _explanation;
  late bool _done;
  late String _createDate;
  late String _updatedDate;

  @override
  void initState() {
    super.initState();
    var todo = widget.todo;

    _title = todo?.title ?? "";
    _explanation = todo?.explanation ?? "";
    _done = todo?.done ?? false;
    _createDate = todo?.createDate ?? "";
    _updatedDate = todo?.updatedDate ?? "";
    _isCreateTodo = todo == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isCreateTodo ? 'add Todo' : 'Modify Todo')),
      body: Container(
        // 余白を付ける
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CheckboxListTile(
                title: const Text("is Done?"),
                value: _done,
                onChanged: (bool? value) {
                  setState(() {
                    _done = value ?? false;
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "タイトル",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              // TextEditingControllerを使用することで、いちいちsetStateしなくても画面を更新してくれる
              controller: TextEditingController(text: _title),
              onChanged: (String value) {
                _title = value;
              },
            ),
            const SizedBox(height: 20),
            // 詳細のテキストフィールド
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 3,
              decoration: const InputDecoration(
                labelText: "詳細",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              // TextEditingControllerを使用することで、いちいちsetStateしなくても画面を更新してくれる
              controller: TextEditingController(text: _explanation),
              onChanged: (String value) {
                _explanation = value;
              },
            ),
            const SizedBox(height: 20),
            // 追加/更新ボタン
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_isCreateTodo) {
                    // Todoを追加する
                    _repo.add(_done, _title, _explanation);
                  } else {
                    // Todoを更新する
                    _repo.update(widget.todo!, _done, _title, _explanation);
                  }
                  // Todoリスト画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text(
                  _isCreateTodo ? '追加' : '更新',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // キャンセルボタン
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Todoリスト画面に戻る
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                child: const Text(
                  "キャンセル",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text("作成日時 : $_createDate"),
            Text("更新日時 : $_updatedDate"),
          ],
        ),
      ),
    );
  }
}
