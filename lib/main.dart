import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/pages/auth_page.dart';
import 'package:flutter_app_pinhome/pages/home_screen.dart';
import 'package:flutter_app_pinhome/pages/login_page.dart';
import 'package:flutter_app_pinhome/pages/personal_area_page.dart';
import 'package:flutter_app_pinhome/pages/registration_page.dart';
import 'package:flutter_app_pinhome/providers/provider.dart';
import 'package:flutter_app_pinhome/services/auth_service.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.white),
      home: FutureBuilder(
        future: AuthService.getToken(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
      routes: {
        '/LoginPage': (context) => LoginPage(),
        '/HomePage': (context) => HomePage(),
        '/AuthPage': (context) => AuthPage(),
        '/RegPage': (context) => RegistrationPage(),
        '/PersonPage': (context) => PersonalAreaPage(),
      },
    ));
  }
}

