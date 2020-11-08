import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                )),
            Container(
              alignment: Alignment.center,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset('images/google.png'),
                      iconSize: 50,
                      onPressed: () {
                        _launchGoogleURL();
                      },
                    ),
                    IconButton(
                      icon: Image.asset('images/facebook.png'),
                      iconSize: 50,
                      onPressed: () {
                        _launchFacebookURL();
                      },
                    ),
                    IconButton(
                      icon: Image.asset('images/yandex.png'),
                      iconSize: 50,
                      onPressed: () {
                        _launchYandexURL();
                      },
                    )
                  ]),
            )
          ],
        ),
      ),
    ));
  }
}

_launchGoogleURL() async {
  const url = 'https://pin-home.herokuapp.com/authorization/google';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchYandexURL() async {
  const url = 'https://pin-home.herokuapp.com/authorization/yandex';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchFacebookURL() async {
  const url = 'https://pin-home.herokuapp.com/authorization/facebook';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
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
