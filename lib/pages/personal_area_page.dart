import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_personal_area_service.dart';
import 'package:flutter_app_pinhome/model/personal_area_model.dart';
import 'package:flutter_app_pinhome/pages/chat.dart';
import 'package:flutter_app_pinhome/pages/create_item.dart';
import 'package:flutter_app_pinhome/pages/search.dart';
import 'package:flutter_app_pinhome/wigets/tab_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';






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
  final double tabBarHeight = 80;
  int _currentIndex = 1;
  final List<Widget> _children = [
    ChatPage(),
    PersonalAreaPage(),
    CreateItemPage(),
    SearchPage()
  ];

  // Uint8List img;
  // String url = "https://backend-pin-home-server.site";

  @override
  void initState() {
    super.initState();
    personalAreaService = new PersonalAreaService();
    model = personalAreaService.get();
    personalAreaService.getUserAvatar().then((value) => url = value);
    // loadImageFromPreferences();
  }

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTappedBar,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('images/chat.png'),
              title: Text("ssd")
            ),BottomNavigationBarItem(
              icon: Image.asset('images/profile.png'),
                title: Text("ssd")
            ),BottomNavigationBarItem(
              icon: Image.asset('images/add_item.png'),
                title: Text("ssd")
            ),BottomNavigationBarItem(
              icon: Image.asset('images/find.png'),
                title: Text("ssd")
            )
          ],
        ),
        // appBar: AppBar(),
          body: buildPersonalAreaPage()
          // SlidingUpPanel(
          //     controller: panelController,
          //     maxHeight: MediaQuery.of(context).size.height - tabBarHeight,
          //     panelBuilder: (scrollController) => buildSlidingPanel(
          //       scrollController: scrollController,
          //       panelController: panelController,
          //     ),
          //     body: Center(
          //       child: Container(
          //           alignment: Alignment.center,
          //           color: Colors.white,
          //           child: FutureBuilder<PersonalAreaRequestModel>(
          //               future: model,
          //               builder: (context, snapshot) {
          //                 if (snapshot.hasData) {
          //                   return Column(
          //                     // mainAxisAlignment: MainAxisAlignment.center,
          //                     // crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: <Widget>[
          //                       Container(
          //                           height: 200,
          //                           alignment: Alignment.center,
          //                           margin: EdgeInsets.only(right: 2,top: 70),
          //                           child: Row(
          //                             children: <Widget>[
          //                               Container(
          //                                   margin:
          //                                   EdgeInsets.only(right: 30, top: 70),
          //                                   alignment: Alignment.topLeft,
          //                                   width: 150,
          //                                   child: CircleAvatar(
          //                                     radius: 80,
          //                                     backgroundImage: NetworkImage(snapshot.data.imgUrl),
          //                                   )
          //                                 // imageFromPreferences,
          //                               ),
          //                               // Container(
          //                               //     margin:
          //                               //         EdgeInsets.only(left: 30, top: 70),
          //                               //     alignment: Alignment.topLeft,
          //                               //     width: 150,
          //                               //     decoration: new BoxDecoration(
          //                               //         shape: BoxShape.circle,
          //                               //         image: new DecorationImage(
          //                               //             fit: BoxFit.fill,
          //                               //             image:
          //                               //                 loadImageFromPreferences()))),
          //                               Container(
          //                                 margin: EdgeInsets.only(top: 70),
          //                                 alignment: Alignment.topRight,
          //                                 child: Column(
          //                                   children: <Widget>[
          //                                     Text(
          //                                         snapshot.data.name +
          //                                             " " +
          //                                             snapshot.data.surname,
          //                                         textDirection: TextDirection.ltr,
          //                                         style: TextStyle(
          //                                             color: HexColor("#FEB904"),
          //                                             fontFamily: 'PTSans',
          //                                             fontSize: 25,
          //                                             fontWeight: FontWeight.w700)),
          //                                     Row(
          //                                       children: [
          //                                         Container(
          //                                           height: 20,
          //                                           width: 20,
          //                                           alignment: Alignment.center,
          //                                           // This is needed
          //                                           margin:
          //                                           EdgeInsets.only(right: 5),
          //                                           child: Image.asset(
          //                                             "images/email.png",
          //                                             fit: BoxFit.contain,
          //                                             width: 300,
          //                                           ),
          //                                         ),
          //                                         Text(snapshot.data.email,
          //                                             textDirection:
          //                                             TextDirection.ltr,
          //                                             style: TextStyle(
          //                                                 color: Colors.black,
          //                                                 fontSize: 16,
          //                                                 fontFamily: 'Open Sans',
          //                                                 fontWeight:
          //                                                 FontWeight.w300)),
          //                                       ],
          //                                     ),
          //                                     Row(
          //                                       children: [
          //                                         Container(
          //                                           height: 20,
          //                                           width: 20,
          //                                           alignment: Alignment.center,
          //                                           // This is needed
          //                                           margin:
          //                                           EdgeInsets.only(right: 5),
          //                                           child: Image.asset(
          //                                             "images/phone.png",
          //                                             fit: BoxFit.contain,
          //                                             width: 300,
          //                                           ),
          //                                         ),
          //                                         Text(snapshot.data.phoneNumber,
          //                                             textDirection:
          //                                             TextDirection.ltr,
          //                                             style: TextStyle(
          //                                                 color: Colors.black,
          //                                                 fontSize: 16,
          //                                                 fontFamily: 'Open Sans',
          //                                                 fontWeight:
          //                                                 FontWeight.w300)),
          //                                       ],
          //                                     ),
          //                                     Row(
          //                                       children: [
          //                                         Container(
          //                                           height: 20,
          //                                           width: 20,
          //                                           alignment: Alignment.center,
          //                                           // This is needed
          //                                           margin:
          //                                           EdgeInsets.only(right: 5),
          //                                           child: Image.asset(
          //                                             "images/place.png",
          //                                             fit: BoxFit.contain,
          //                                             width: 300,
          //                                           ),
          //                                         ),
          //                                         Text(snapshot.data.geolocation,
          //                                             textDirection:
          //                                             TextDirection.ltr,
          //                                             style: TextStyle(
          //                                                 color: Colors.black,
          //                                                 fontSize: 16,
          //                                                 fontFamily: 'Open Sans',
          //                                                 fontWeight:
          //                                                 FontWeight.w300)),
          //                                       ],
          //                                     ),
          //                                   ],
          //                                 ),
          //                               )
          //                             ],
          //                           )),
          //                       Container(
          //                         margin: EdgeInsets.only(top: 100),
          //                         child: Column(children: <Widget>[
          //                           _editButtonField(),
          //                           _changePasswordButtonField(),
          //                           _helpButtonField(),
          //                           _logoutButtonField()
          //                         ]),
          //                       ),
          //                     ],
          //                   );
          //                 } else if (snapshot.hasError) {
          //                   return Text("${snapshot.error}");
          //                 }
          //                 return CircularProgressIndicator();
          //               })
          //         //
          //       )),
          // ),
    );
  }

  Widget buildPersonalAreaPage(){
    return SlidingUpPanel(
      controller: panelController,
      maxHeight: MediaQuery.of(context).size.height - tabBarHeight,
      panelBuilder: (scrollController) => buildSlidingPanel(
        scrollController: scrollController,
        panelController: panelController,
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
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              height: 200,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 2,top: 70),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      margin:
                                      EdgeInsets.only(right: 30, top: 70),
                                      alignment: Alignment.topLeft,
                                      width: 150,
                                      child: CircleAvatar(
                                        radius: 80,
                                        backgroundImage: NetworkImage(snapshot.data.imgUrl),
                                      )
                                    // imageFromPreferences,
                                  ),
                                  // Container(
                                  //     margin:
                                  //         EdgeInsets.only(left: 30, top: 70),
                                  //     alignment: Alignment.topLeft,
                                  //     width: 150,
                                  //     decoration: new BoxDecoration(
                                  //         shape: BoxShape.circle,
                                  //         image: new DecorationImage(
                                  //             fit: BoxFit.fill,
                                  //             image:
                                  //                 loadImageFromPreferences()))),
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
                                              margin:
                                              EdgeInsets.only(right: 5),
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
                                              margin:
                                              EdgeInsets.only(right: 5),
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
                                              margin:
                                              EdgeInsets.only(right: 5),
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
                            margin: EdgeInsets.only(top: 100),
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
    @required PanelController panelController,
    @required ScrollController scrollController,
  }) =>
      DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: buildTabBar(
            onClicked: panelController.open,
          ),
          body: TabBarView(
            children: [
              TabWidget(scrollController: scrollController),
              TabWidget(scrollController: scrollController),
            ],
          ),
        ),
      );

  Widget buildTabBar({
    @required VoidCallback onClicked,
  }) =>
      PreferredSize(
        preferredSize: Size.fromHeight(tabBarHeight - 8),
        child: GestureDetector(
          onTap: onClicked,
          child: AppBar(
            title: buildDragIcon(), // Icon(Icons.drag_handle),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(child: Text('Vegetarian')),
                Tab(child: Text('Non Vegetarian')),
              ],
            ),
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
            onPressed: () {},
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
