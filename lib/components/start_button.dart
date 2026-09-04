import 'package:flutter/material.dart';

class StartButton extends StatefulWidget {
  const new({super.key});

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("======================= STARTING =====================");
      },
      onTapDown: (details) {
        setState(() {
          _backgroundColor = Colors.green;
        });
      },
      onTapUp: (_) {
        setState(() {
          _backgroundColor = Colors.white;
        });
      },
      onTapCancel: () {
        setState(() {
          _backgroundColor = Colors.white;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          border: Border.all(
            color: Colors.black,
            width: 4.0,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: Text(
          style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          "START SHOOTIN'",
        ),
      ),
    );
  }
}
