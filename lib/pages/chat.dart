import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
          child: new Text("Chat"),
        ),
        appBar: new AppBar(
          title: new Text("Chat"),
        ));
  }
}
