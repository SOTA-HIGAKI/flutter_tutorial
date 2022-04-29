import 'package:flutter/material.dart';

class SquareButtonBaseWidget extends StatefulWidget {
  final void Function()? onPressed;
  final Color color;
  final String text;
  final double? width;
  final double? height;
  const SquareButtonBaseWidget(
      {Key? key,
      this.onPressed,
      required this.color,
      required this.text,
      this.width,
      this.height})
      : super(key: key);

  @override
  State<SquareButtonBaseWidget> createState() => _SquareButtonBaseWidgetState();
}

class _SquareButtonBaseWidgetState extends State<SquareButtonBaseWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: () {
          widget.onPressed;
        },
        child: Text(widget.text),
        style: ElevatedButton.styleFrom(primary: widget.color),
      ),
    );
  }
}

class CircleButtonBaseWidget extends StatefulWidget {
  final void Function()? onPressed;
  final Color color;
  final Icon icon;

  const CircleButtonBaseWidget(
      {Key? key,
      this.onPressed,
      required this.color,
      required this.icon})
      : super(key: key);

  @override
  State<CircleButtonBaseWidget> createState() => _CircleButtonBaseWidgetState();
}

class _CircleButtonBaseWidgetState extends State<CircleButtonBaseWidget> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: widget.color,
      foregroundColor: Colors.black,
      onPressed: () {
        widget.onPressed;
      },
      child: widget.icon,
    );
  }
}
