import 'package:flutter/material.dart';
import 'package:flutter_first_app/colors.dart';
import 'package:flutter_first_app/widgets/button.dart';
import 'package:flutter_first_app/widgets/text_box.dart';
import 'package:provider/provider.dart';

class WidgetApp extends StatelessWidget {
  const WidgetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "widget app",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WidgetPage(),
    );
  }
}

class WidgetPage extends StatefulWidget {
  const WidgetPage({Key? key}) : super(key: key);
  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hogehoge"),
      ),
      body: ChangeNotifierProvider(
          create: (context) => PasswordVisibilityController(visible: false),
          child: Center(
              child: Card(
                  child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: ListView(children: [
                        PasswordField(
                          color: MyColors.black2,
                        ),
                        NormalFormField(
                          color: MyColors.black2,
                          labelText: "mail",
                        ),
                        SquareButtonBaseWidget(
                            text: "a", color: MyColors.black2),
                        CircleButtonBaseWidget(
                            icon: const Icon(Icons.add), color: MyColors.black2)
                      ]))))),
    );
  }
}
