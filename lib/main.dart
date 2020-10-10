import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/pages/auth_page.dart';
import 'package:flutter_app_pinhome/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/LoginPage': (context) => LoginPage(),
        '/AuthPage': (context) => AuthPage()
      },
    );
  }
}
