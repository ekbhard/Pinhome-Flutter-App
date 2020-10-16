import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/blocs/auth_form_bloc.dart';
import 'package:flutter_app_pinhome/blocs/personal_area_form_bloc.dart';
import 'package:flutter_app_pinhome/providers/personal_area_provider.dart';
import 'package:flutter_app_pinhome/providers/provider.dart';

class PersonalAreaPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // final PersonalAreaFormBloc formBloc = PersonalAreaProvider.of(context);

    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                LogoImage(),
                TextAuth(),
                _usernameField(),
                _passwordField(),
                _buttonField()
              ],
            ),
          ),
        ));
  }

  Widget _usernameField() {
      // return StreamBuilder<String>(
      //     stream: bloc.name,
      //     builder: (context, snapshot) {
            return TextField(
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  icon: Icon(Icons.account_box),
                  contentPadding: const EdgeInsets.all(20.0),
                  labelText: 'Имя'),
              // onChanged: bloc.changeName,
            );
          // });
    }

    Widget _buttonField() {
      return StreamBuilder<bool>(
          // stream: bloc.submitValidForm,
          builder: (context, snapshot) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(24),
              child: ButtonTheme(
                  minWidth: 250,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return null;
                      }
                      // bloc.createPersonalArea(context);
                    },
                    color: Colors.amber[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Text('Подтвердить',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w300)),
                  )),
            );
          });
    }

    Widget _passwordField() {
      // return StreamBuilder<String>(
      //     stream: bloc.surname,
      //     builder: (context, snapshot) {
            return TextField(
              obscureText: true,
              // onChanged: bloc.changeSurname,
              maxLength: 20,
              decoration: const InputDecoration(
                  icon: Icon(Icons.visibility_off),
                  contentPadding: const EdgeInsets.all(20.0),
                  labelText: 'Фимилия'),
            );
          // });
    }

  // Widget _usernameField(PersonalAreaFormBloc bloc) {
  //   return StreamBuilder<String>(
  //       stream: bloc.name,
  //       builder: (context, snapshot) {
  //         return TextField(
  //           keyboardType: TextInputType.name,
  //           decoration: const InputDecoration(
  //               icon: Icon(Icons.account_box),
  //               contentPadding: const EdgeInsets.all(20.0),
  //               labelText: 'Имя'),
  //           onChanged: bloc.changeName,
  //         );
  //       });
  // }
  //
  // Widget _buttonField(PersonalAreaFormBloc bloc) {
  //   return StreamBuilder<bool>(
  //       stream: bloc.submitValidForm,
  //       builder: (context, snapshot) {
  //         return Container(
  //           alignment: Alignment.center,
  //           margin: EdgeInsets.all(24),
  //           child: ButtonTheme(
  //               minWidth: 250,
  //               height: 40,
  //               child: RaisedButton(
  //                 onPressed: () {
  //                   if (snapshot.hasError) {
  //                     print(snapshot.error);
  //                     return null;
  //                   }
  //                   bloc.createPersonalArea(context);
  //                 },
  //                 color: Colors.amber[300],
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: new BorderRadius.circular(10.0)),
  //                 child: Text('Подтвердить',
  //                     textDirection: TextDirection.ltr,
  //                     style: TextStyle(
  //                         decoration: TextDecoration.none,
  //                         color: Colors.black,
  //                         fontSize: 16,
  //                         fontFamily: 'Open Sans',
  //                         fontWeight: FontWeight.w300)),
  //               )),
  //         );
  //       });
  // }
  //
  // Widget _passwordField(PersonalAreaFormBloc bloc) {
  //   return StreamBuilder<String>(
  //       stream: bloc.surname,
  //       builder: (context, snapshot) {
  //         return TextField(
  //           obscureText: true,
  //           onChanged: bloc.changeSurname,
  //           maxLength: 20,
  //           decoration: const InputDecoration(
  //               icon: Icon(Icons.visibility_off),
  //               contentPadding: const EdgeInsets.all(20.0),
  //               labelText: 'Фимилия'),
  //         );
  //       });
  // }
}

class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Image image = Image(
        image: new AssetImage('images/logo_2.png'), width: 65, height: 65);
    return Container(margin: EdgeInsets.only(top: 100), child: image);
  }
}

class TextAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 70),
        child: Text('Заполнение информации личного кабинета',
            textDirection: TextDirection.ltr,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700)));
  }
}
