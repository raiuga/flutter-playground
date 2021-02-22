import 'package:flutter/material.dart';
import './custom_text.dart';
import './text_control.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  var _textToShow = 'Some text below';

  void _changeText() {
    setState(() {
      _textToShow = _textToShow == 'Some text below it'
          ? 'Another Random Text'
          : 'Some text below it';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter assignment'),
        ),
        body: Column(
          children: <Widget>[
            CustomText(_textToShow),
            TextControl(_changeText),
          ],
        ),
      ),
    );
  }
}
