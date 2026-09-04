import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitButton extends StatefulWidget {
  const new({super.key});

  @override
  State<ExitButton> createState() => _ExitButtonState();
}

class _ExitButtonState extends State<ExitButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemNavigator.pop();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(
            color: Colors.white,
            width: 4.0,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: Text(
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          "EXIT",
        ),
      ),
    );
  }
}
