import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_auth_service.dart';
import 'package:flutter_app_pinhome/model/registration_model.dart';

import 'auth_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool hidePassword = true;
  bool _autoValidate = false;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  RegistrationRequestModel requestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AuthService service;

  @override
  void initState() {
    super.initState();
    requestModel = new RegistrationRequestModel();
    service = new AuthService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(),
        body: Center(
            child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Form(
            autovalidate: _autoValidate,
            key: globalFormKey,
            child: ListView(
              children: <Widget>[
                LogoImage(),
                TextAuth(),
                _usernameField(),
                _passwordField(),
                _buttonField()
              ],
            ),
          ),
        )));
  }

  Widget _usernameField() {
    return TextFormField(
      onSaved: (input) => requestModel.username = input,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
          icon: Icon(Icons.account_box),
          contentPadding: const EdgeInsets.all(20.0),
          labelText: 'Name',
          hintText: 'someone@company.com'),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      onSaved: (input) => requestModel.password = input,
      maxLength: 20,
      decoration: const InputDecoration(
          icon: Icon(Icons.visibility_off),
          contentPadding: const EdgeInsets.all(20.0),
          labelText: 'Password',
          hintText: 'Enter password'),
    );
  }

  Widget _buttonField() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(24),
      child: ButtonTheme(
          minWidth: 250,
          height: 40,
          child: RaisedButton(
            onPressed: () {
              if (validateAndSave()) {
                print(requestModel.toJson());
                setState(() {
                  isApiCallProcess = true;
                });

                AuthService apiService = new AuthService();
                apiService.registration(requestModel).then((value) {
                  if (value == null || value.error != null) {
                    scaffoldKey.currentState.showSnackBar(
                        new SnackBar(content: new Text(value.message)));
                  } else if (value != null) {
                    setState(() {
                      isApiCallProcess = false;
                    });
                    if (value.error == null) {
                      // final snackBar =
                      //     SnackBar(content: Text("Registration Successful"));
                      // scaffoldKey.currentState.showSnackBar(snackBar);
                      return Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AuthPage()));
                    }
                  }
                });
              }
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
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
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
