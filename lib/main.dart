import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/pages/auth_page.dart';
import 'package:flutter_app_pinhome/pages/home_screen.dart';
import 'package:flutter_app_pinhome/pages/login_page.dart';
import 'package:flutter_app_pinhome/pages/create_personal_area_page.dart';
import 'package:flutter_app_pinhome/pages/personal_area_page.dart';
import 'package:flutter_app_pinhome/pages/registration_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home: LoginPage(),
      routes: {
        '/LoginPage': (context) => LoginPage(),
        '/HomePage': (context) => HomePage(),
        '/AuthPage': (context) => AuthPage(),
        '/RegPage': (context) => RegistrationPage(),
        '/CreatePersonPage': (context) => CreatePersonalAreaPage(),
        '/PersonPage': (context) => PersonalAreaPage(),
      },
    );
  }
}
