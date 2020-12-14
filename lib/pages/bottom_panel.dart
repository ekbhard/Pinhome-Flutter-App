import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/pages/create_announsmet_page.dart';
import 'package:flutter_app_pinhome/pages/personal_area_page.dart';
import 'package:flutter_app_pinhome/pages/search.dart';

class BottomPanel extends StatefulWidget {
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PersonalAreaPage(),
    CreateAnnounsmentPage(),
    SearchPage()
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: onTappedBar,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('images/profile.png'),
                title: Text("profile")),
            BottomNavigationBarItem(
                icon: Image.asset('images/add_item.png'),
                title: Text("add_item")),
            BottomNavigationBarItem(
                icon: Image.asset('images/find.png'), title: Text("find"))
          ],
        ),
        body: _children[_currentIndex],
      ),
    );
  }
}
