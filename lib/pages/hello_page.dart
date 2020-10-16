import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelloPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.only(left: 10.0, top: 40.0),
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LogoImage(),
            Text('Pinhome',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'PTSans',
                    fontWeight: FontWeight.w700)),
            Text('Сервис обмена товаров',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.amber[300],
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w300)),
            FlatButton(color: Colors.white,)
          ],
        ),
      ),
    ));
  }
}

class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Image image =
        Image(image: new AssetImage('images/logo.png'), width: 97, height: 97);
    return Container(child: image);
  }
}
