import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_auth_service.dart';
import 'package:flutter_app_pinhome/model/login_model.dart';
import 'package:flutter_app_pinhome/pages/login_page.dart';
import 'package:flutter_app_pinhome/pages/personal_area_page.dart';

import '../ProgressHUD.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  @override
  Widget _uiSetup(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(),
        body: Center(
            child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Form(
            key: globalFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                LogoImage(),
                TextAuth(),
                new TextFormField(
                    keyboardType: TextInputType.name,
                    // validator: (input) => !input.contains('@')
                    //     ? "Email Id should be valid"
                    //     : null,
                    onSaved: (input) => loginRequestModel.username = input,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.account_box),
                        contentPadding: const EdgeInsets.all(20.0),
                        labelText: 'Name',
                        hintText: 'someone@company.com')),
                // _usernameField(),
                new TextFormField(
                  obscureText: true,
                  onSaved: (input) => loginRequestModel.password = input,
                  validator: (input) => input.length < 3
                      ? "Password should be more than 3 characters"
                      : null,
                  maxLength: 20,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.visibility_off),
                      contentPadding: const EdgeInsets.all(20.0),
                      labelText: 'Password',
                      hintText: 'Enter password'),
                ),
                // _passwordField(),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(24),
                  child: ButtonTheme(
                      minWidth: 250,
                      height: 40,
                      child: RaisedButton(
                        onPressed: () {
                          if (validateAndSave()) {
                            print(loginRequestModel.toJson());
                            setState(() {
                              isApiCallProcess = true;
                            });

                            AuthService apiService = new AuthService();
                            apiService.login(loginRequestModel).then((value) {
                              if (value == null) {
                                return Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              }
                              if (value.error != null) {
                                final snackBar =
                                    SnackBar(content: Text(value.error));
                                scaffoldKey.currentState.showSnackBar(snackBar);
                              }
                              if (value != null) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                if (!value.have) {
                                  return Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PersonalAreaPage()));
                                }
                                if (value.token.isNotEmpty) {
                                  final snackBar = SnackBar(
                                      content: Text("Login Successful"));
                                  scaffoldKey.currentState
                                      .showSnackBar(snackBar);
                                  // Navigator.pushNamed(context, '/AuthPage');
                                } else {
                                  final snackBar =
                                      SnackBar(content: Text(value.error));
                                  scaffoldKey.currentState
                                      .showSnackBar(snackBar);
                                }
                              }
                            });
                          }
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
                )

                // _buttonField()
              ],
            ),
          ),
        )));
  }

  Widget _passwordField() {
    return Container(
        child: TextFormField(
      obscureText: true,
      onSaved: (input) => loginRequestModel.password = input,
      validator: (input) =>
          input.length < 3 ? "Password should be more than 3 characters" : null,
      maxLength: 20,
      decoration: const InputDecoration(
          icon: Icon(Icons.visibility_off),
          contentPadding: const EdgeInsets.all(20.0),
          labelText: 'Password',
          hintText: 'Enter password'),
    ));
  }

  Widget _usernameField() {
    return Container(
        child: TextFormField(
            keyboardType: TextInputType.name,
            // validator: (input) => !input.contains('@')
            //     ? "Email Id should be valid"
            //     : null,
            onSaved: (input) => loginRequestModel.username = input,
            decoration: const InputDecoration(
                icon: Icon(Icons.account_box),
                contentPadding: const EdgeInsets.all(20.0),
                labelText: 'Name',
                hintText: 'someone@company.com')));
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
              print(loginRequestModel.toJson());

              setState(() {
                isApiCallProcess = true;
              });

              AuthService apiService = new AuthService();
              apiService.login(loginRequestModel).then((value) {
                if (value != null) {
                  setState(() {
                    isApiCallProcess = false;
                  });
                  if (value == null) {
                    return LoginPage();
                  }

                  if (value.token.isNotEmpty) {
                    final snackBar =
                        SnackBar(content: Text("Login Successful"));
                    scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(content: Text(value.error));
                    scaffoldKey.currentState.showSnackBar(snackBar);
                  }
                }
              });
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
        child: Text('Авторизация',
            textDirection: TextDirection.ltr,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700)));
  }
}
