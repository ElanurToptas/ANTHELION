import 'package:flutter/material.dart';

class SingleButtonWidget extends StatefulWidget {
  @override
  _SingleButtonWidgetState createState() => _SingleButtonWidgetState();
}

class _SingleButtonWidgetState extends State<SingleButtonWidget> {
  bool _buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _buttonPressed = !_buttonPressed;
        });
      },
      child: Text(_buttonPressed ? 'Basıldı' : 'Bas'),
    );
  }
}
