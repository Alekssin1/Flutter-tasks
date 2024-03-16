import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class ButtonWidget extends StatefulWidget {
  final String text;

  ButtonWidget(this.text);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          isPressed = !isPressed;
        });
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          isPressed ? Colors.white : Colors.white.withOpacity(0.1),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: Colors.white.withOpacity(0.2),
              width: 1.0,
            ),
          ),
        ),
        elevation: MaterialStateProperty.all<double>(isPressed ? 5.0 : 0.0),
        shadowColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0.5)),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: isPressed ? Colors.black : Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
