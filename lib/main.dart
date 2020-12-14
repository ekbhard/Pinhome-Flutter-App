import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/pages/announcement_page.dart';
import 'package:flutter_app_pinhome/pages/auth_page.dart';
import 'package:flutter_app_pinhome/pages/bottom_panel.dart';
import 'package:flutter_app_pinhome/pages/closed_announcement_page.dart';
import 'package:flutter_app_pinhome/pages/copy_info_page.dart';
import 'package:flutter_app_pinhome/pages/create_announsmet_page.dart';
import 'package:flutter_app_pinhome/pages/eco_poject_page.dart';
import 'package:flutter_app_pinhome/pages/home_screen.dart';
import 'package:flutter_app_pinhome/pages/service_ans_support_page.dart';
import 'package:flutter_app_pinhome/pages/login_page.dart';
import 'package:flutter_app_pinhome/pages/create_personal_area_page.dart';
import 'package:flutter_app_pinhome/pages/personal_area_page.dart';
import 'package:flutter_app_pinhome/pages/registration_page.dart';
import 'package:flutter_app_pinhome/pages/show_announcement_page.dart';
import 'package:flutter_app_pinhome/pages/update_personal_area_page.dart';
import 'package:flutter_app_pinhome/pages/variants_exchange_page.dart';

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
        '/BottomPanelPage': (context) => BottomPanel(),
        '/CreateAnnounsment': (context) => CreateAnnounsmentPage(),
        '/InfoCpy': (context) => InfoCpy(),
        '/AnnounsmentPage': (context) => AnnounsmentPage(),
        '/EcoPoject': (context) => EcoPoject(),
        '/Project': (context) => Project(),
        '/VariantsExchangePage': (context) => VariantsExchangePage(),
        '/ShowAnnounsmentPage': (context) => ShowAnnounsmentPage(),
        '/ClosedAnnounsmentPage': (context) => ClosedAnnounsmentPage(),
        '/UpdatePersonalAreaPage': (context) => UpdatePersonalAreaPage(),
        '/ServiceAnsSupportPage': (context) => ServiceAnsSupportPage(),
      },
    );
  }
}
