import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.only(top: 40.0),
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LogoImage(),
            TextWelcome(),
            TextSlogan(),
            ButtonTheme(
                minWidth: 250,
                height: 40,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/AuthPage');
                  },
                  color: Colors.amber[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  child: Text('Войти',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w300)),
                )),
            ButtonTheme(
                minWidth: 250,
                height: 40,
                child: RaisedButton(
                  // padding: EdgeInsets.all(50),
                  onPressed: () {
                    Navigator.pushNamed(context, '/RegPage');
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 3, color: Colors.amber[300]),
                      borderRadius: new BorderRadius.circular(10.0)),
                  child: Text('Зарегистрироваться',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w300)),
                ))
          ],
        ),
      ),
    ));
  }
}

class TextSlogan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 60),
        child: Text('От скрепки до квартиры — все в ваших руках!',
            textDirection: TextDirection.ltr,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w300)));
  }
}

class TextWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 70),
        child: Text('Добро пожаловать!',
            textDirection: TextDirection.ltr,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700)));
  }
}

class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Image image = Image(
        image: new AssetImage('images/logo_2.png'), width: 65, height: 65);
    return Container(padding: EdgeInsets.only(bottom: 100), child: image);
  }
}
