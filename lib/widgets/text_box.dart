import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget getTexts(List<String> strings) {
  List<Widget> list = <Widget>[];
  for (var i = 0; i < strings.length; i++) {
    list.add(Text(strings[i]));
  }
  return Row(children: list);
}

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final AutovalidateMode autovalidateMode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Color color;
  const PasswordField(
      {Key? key,
      this.controller,
      this.hintText,
      this.autovalidateMode = AutovalidateMode.disabled,
      this.validator,
      this.onChanged,
      required this.color})
      : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late TextEditingController _controller;
  TextEditingController get _textController => _controller;
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visible = context.watch<PasswordVisibilityController>().value;
    return TextFormField(
      controller: _textController,
      maxLength: 20,
      cursorColor: widget.color,
      keyboardType: TextInputType.visiblePassword,
      autovalidateMode: widget.autovalidateMode,
      obscureText: !visible,
      style: TextStyle(color: widget.color),
      decoration: InputDecoration(
          focusColor: widget.color,
          hintText: widget.hintText,
          labelText: 'パスワード',
          counterText: "",
          // errorText: '8文字以上入力してください',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.color,
              width: 2.0,
            ),
          ),
          border: const OutlineInputBorder(),
          labelStyle: TextStyle(
            color: widget.color,
          ),
          suffixIcon: TextButton(
            onPressed: () {
              final visibility = context.read<PasswordVisibilityController>();
              visibility.value = !visibility.value;
            },
            child: visible
                ? Text(
                    "非表示",
                    style: TextStyle(color: widget.color),
                  )
                : Text("表示", style: TextStyle(color: widget.color)),
          )),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}

class NormalFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final AutovalidateMode autovalidateMode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Color color;
  final String labelText;
  const NormalFormField(
      {Key? key,
      this.controller,
      this.hintText,
      this.autovalidateMode = AutovalidateMode.disabled,
      this.validator,
      this.onChanged,
      required this.color,
      required this.labelText})
      : super(key: key);

  @override
  State<NormalFormField> createState() => _NormalFormFieldState();
}

class _NormalFormFieldState extends State<NormalFormField> {
  late TextEditingController _controller;
  TextEditingController get _textController => _controller;
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textController,
      maxLength: 20,
      cursorColor: widget.color,
      keyboardType: widget.labelText == "mail"  // 随時追加
          ? TextInputType.emailAddress
          : TextInputType.text,
      autovalidateMode: widget.autovalidateMode,
      style: TextStyle(color: widget.color),
      decoration: InputDecoration(
        focusColor: widget.color,
        hintText: widget.hintText,
        labelText: widget.labelText,
        counterText: "",
        // errorText: '8文字以上入力してください',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.color,
            width: 2.0,
          ),
        ),
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(
          color: widget.color,
        ),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}

class PasswordVisibilityController extends ValueNotifier<bool> {
  PasswordVisibilityController({required bool visible}) : super(visible);

  bool get visible => value;

  set visible(bool newValue) {
    value = newValue;
  }
}

class PasswordTextField extends TextField {
  PasswordTextField(BuildContext context, bool _showPassword, {Key? key})
      : super(
          key: key,
          obscureText: !_showPassword,
          controller: TextEditingController(),
          decoration: InputDecoration(
              labelText: "Password",
              suffixIcon: IconButton(
                icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  // setState(() {
                  //   _showPassword = !_showPassword;
                  // });
                },
              )),
        );
}
