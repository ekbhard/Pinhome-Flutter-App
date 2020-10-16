import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/blocs/auth_form_bloc.dart';
import 'package:flutter_app_pinhome/providers/provider.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthFormBloc formBloc = Provider.of(context);

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
                _usernameField(formBloc),
                _passwordField(formBloc),
                _buttonField(formBloc)
              ],
            ),
          ),
        ));
  }

  Widget _usernameField(AuthFormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.username,
        builder: (context, snapshot) {
          return TextField(
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
                icon: Icon(Icons.account_box),
                contentPadding: const EdgeInsets.all(20.0),
                labelText: 'Name',
                hintText: 'someone@company.com'),
            onChanged: bloc.changeUsername,
          );
        });
  }

  Widget _buttonField(AuthFormBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.submitValidForm,
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
                    bloc.register(context);
                  },
                  color: Colors.amber[300],
                  shape: RoundedRectangleBorder(
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
          );
        });
  }

  Widget _passwordField(AuthFormBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.password,
        builder: (context, snapshot) {
          return TextField(
            obscureText: true,
            onChanged: bloc.changePassword,
            maxLength: 20,
            decoration: const InputDecoration(
                icon: Icon(Icons.visibility_off),
                contentPadding: const EdgeInsets.all(20.0),
                labelText: 'Password',
                hintText: 'Enter password'),
          );
        });
  }
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
        child: Text('Регистрация',
            textDirection: TextDirection.ltr,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700)));
  }
}
