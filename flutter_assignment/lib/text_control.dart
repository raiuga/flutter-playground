import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final Function onPressHandler;
  TextControl(this.onPressHandler);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressHandler,
      child: Text('Click me to change Text'),
    );
  }
}
