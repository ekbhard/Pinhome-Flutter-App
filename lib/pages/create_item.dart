import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateItemPage extends StatefulWidget {
  @override
  _CreateItemPageState createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text("create Item"),
      ),
      appBar: new AppBar(
        title: new Text("Create"),
      )

    );
  }
}
