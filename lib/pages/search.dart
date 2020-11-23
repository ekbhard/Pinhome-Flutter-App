import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _folded = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            new Text('Поиск',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700)),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  bar(),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Image.asset(
                      "images/search.png",
                      fit: BoxFit.fill,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              child: SizedBox(
                height: 400,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    getCard2(),
                    getCard1(),
                    getCard3(),
                    // Flexible(child: getCard1()),
                    // Flexible(child: getCard3())
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget bar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: 300,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        boxShadow: kElevationToShadow[6],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              child: !_folded
                  ? TextField(
                      decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.blue[300]),
                          border: InputBorder.none),
                    )
                  : null,
            ),
          ),
          Container(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_folded ? 32 : 0),
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(_folded ? 32 : 0),
                  bottomRight: Radius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    _folded ? Icons.search : Icons.close,
                    color: Colors.blue[900],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _folded = !_folded;
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget getCard1() {
  var descr = "Apple Watch";
  var picUrl =
      "https://images11.esquire.ru/upload/img_cache/74c/74c2f973ec1defcdf2ec832cc8523286_ce_1960x1222x0x1_cropped_960x600.jpg";
  return Card(
      elevation: 1.5,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 60,
            width: 320,
            child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60 / 2),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(picUrl))),
                ),
                title: Text(
                  descr,
                  style: TextStyle(fontSize: 17),
                )),
          )));
}

Widget getCard2() {
  var descr = "Зарядка Nokia";
  var picUrl =
      "https://all-gsm.ru/photo/600/setevoe-zaryadnoe-ustroystvo-dlya-nokia-35-mm-eltronic-1884.jpg";
  return Card(
      elevation: 1.5,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 60,
            width: 320,
            child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60 / 2),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(picUrl))),
                ),
                title: Text(
                  descr,
                  style: TextStyle(fontSize: 17),
                )),
          )));
}

Widget getCard3() {
  var descr = "Зарядка Nokia";
  var picUrl =
      "https://static.first-buggy.ru/catalog/Joie/Litetrax-4/big/joie-litetrax-4-cashew-2019.jpg";
  return Card(
      elevation: 1.5,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 60,
            width: 320,
            child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60 / 2),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(picUrl))),
                ),
                title: Text(
                  descr,
                  style: TextStyle(fontSize: 17),
                )),
          )));
}
