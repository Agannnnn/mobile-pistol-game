import 'package:flutter/material.dart';

class ReloadButton extends StatefulWidget {
  const new({super.key, required this.reload, required this.disabled});

  final Function reload;
  final bool disabled;

  @override
  State<ReloadButton> createState() => _ReloadButtonState();
}

class _ReloadButtonState extends State<ReloadButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.disabled) {
          widget.reload();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 4.0,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: Text(
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: widget.disabled
                ? Color.fromRGBO(0, 0, 0, 0.5)
                : Colors.black,
          ),
          "RELOAD",
        ),
      ),
    );
  }
}
