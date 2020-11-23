import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_personal_area_service.dart';
import 'package:flutter_app_pinhome/model/personal_area_model.dart';
import 'package:flutter_app_pinhome/wigets/announcement_wiget.dart';
import 'package:flutter_app_pinhome/wigets/tab_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'info_page.dart';

class PersonalAreaPage extends StatefulWidget {
  @override
  _PersonalAreaPageState createState() => _PersonalAreaPageState();
}

class _PersonalAreaPageState extends State<PersonalAreaPage> {
  Future<PersonalAreaRequestModel> model;
  final storage = new FlutterSecureStorage();
  final panelController = PanelController();
  PersonalAreaService personalAreaService;
  String url;
  final double tabBarHeight = 100;

  @override
  void initState() {
    super.initState();
    personalAreaService = new PersonalAreaService();
    model = personalAreaService.get();
    personalAreaService.getUserAvatar().then((value) => url = value);
    // loadImageFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildPersonalAreaPage());
  }

  Widget buildPersonalAreaPage() {
    return SlidingUpPanel(
      // controller: panelController,
      // maxHeight: MediaQuery.of(context).size.height - tabBarHeight,
      maxHeight: MediaQuery.of(context).size.height - tabBarHeight,
      minHeight: 50,
      // maxHeight: MediaQuery.of(context).size.height - tabBarHeight,
      panelBuilder: (scrollController) => buildSlidingPanel(
        scrollController: scrollController,
        // panelController: panelController,
      ),
      body: Center(
          child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: FutureBuilder<PersonalAreaRequestModel>(
                  future: model,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          Container(
                              height: 200,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 10, top: 10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 30, right: 30, top: 70),
                                      alignment: Alignment.topLeft,
                                      width: 150,
                                      child: CircleAvatar(
                                        radius: 80,
                                        backgroundImage:
                                            NetworkImage(snapshot.data.imgUrl),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(top: 70),
                                    alignment: Alignment.topRight,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                            snapshot.data.name +
                                                " " +
                                                snapshot.data.surname,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                                color: HexColor("#FEB904"),
                                                fontFamily: 'PTSans',
                                                fontSize: 25,
                                                fontWeight: FontWeight.w700)),
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              alignment: Alignment.center,
                                              // This is needed
                                              margin: EdgeInsets.only(right: 5),
                                              child: Image.asset(
                                                "images/email.png",
                                                fit: BoxFit.contain,
                                                width: 300,
                                              ),
                                            ),
                                            Text(snapshot.data.email,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'Open Sans',
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              alignment: Alignment.center,
                                              // This is needed
                                              margin: EdgeInsets.only(right: 5),
                                              child: Image.asset(
                                                "images/phone.png",
                                                fit: BoxFit.contain,
                                                width: 300,
                                              ),
                                            ),
                                            Text(snapshot.data.phoneNumber,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'Open Sans',
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              alignment: Alignment.center,
                                              // This is needed
                                              margin: EdgeInsets.only(right: 5),
                                              child: Image.asset(
                                                "images/place.png",
                                                fit: BoxFit.contain,
                                                width: 300,
                                              ),
                                            ),
                                            Text(snapshot.data.geolocation,
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'Open Sans',
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Column(children: <Widget>[
                              _editButtonField(),
                              _changePasswordButtonField(),
                              _helpButtonField(),
                              _logoutButtonField()
                            ]),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  })
              //
              )),
    );
  }

  Widget buildSlidingPanel({
    @required ScrollController scrollController,
  }) =>
      DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: buildTabBar(
              // onClicked: panelController.open,
              ),
          body: TabBarView(
            children: [
              AnnouncementWidget(scrollController: scrollController),
              TabWidget(scrollController: scrollController),
              TabWidget(scrollController: scrollController),
            ],
          ),
        ),
      );

  Widget buildTabBar() => PreferredSize(
        preferredSize: Size.fromHeight(tabBarHeight - 8),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
              alignment: Alignment.topCenter, child: Icon(Icons.drag_handle)),
          // Icon(Icons.drag_handle),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(icon: Image.asset("images/bag.png")),
              Tab(child: Image.asset('images/heart.png')),
              Tab(child: Image.asset('images/hands.png')),
            ],
          ),
        ),
      );

  Widget buildDragIcon() => Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        width: 40,
        height: 8,
      );

  Widget _editButtonField() {
    return Container(
      alignment: Alignment.center,
      child: ButtonTheme(
          minWidth: 250,
          height: 40,
          child: RaisedButton(
            onPressed: () {},
            color: Colors.amber[300],
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            child: Text('Редактировать',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w300)),
          )),
    );
  }

  Widget _changePasswordButtonField() {
    return Container(
      alignment: Alignment.center,
      child: ButtonTheme(
          minWidth: 250,
          height: 40,
          child: RaisedButton(
            onPressed: () {},
            color: Colors.amber[300],
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            child: Text('Изменить пароль',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w300)),
          )),
    );
  }

  Widget _helpButtonField() {
    return Container(
      alignment: Alignment.center,
      child: ButtonTheme(
          minWidth: 250,
          height: 40,
          child: RaisedButton(
            onPressed: () {
              return Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Info()));
            },
            color: Colors.amber[300],
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            child: Text('Помощь',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w300)),
          )),
    );
  }

  Widget _logoutButtonField() {
    return Container(
      alignment: Alignment.center,
      child: ButtonTheme(
          minWidth: 250,
          height: 40,
          child: RaisedButton(
            onPressed: () {},
            color: Colors.amber[300],
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            child: Text('Выйти',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w300)),
          )),
    );
  }
}
