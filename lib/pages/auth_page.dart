import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_auth_service.dart';
import 'package:flutter_app_pinhome/model/login_model.dart';
import 'package:flutter_app_pinhome/pages/create_personal_area_page.dart';
import 'package:flutter_app_pinhome/pages/login_page.dart';

import '../ProgressHUD.dart';
import 'bottom_panel.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  LoginRequestModel loginRequestModel;
  GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
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

  void showInSnackBar(String value) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
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
            key: _globalFormKey,
            child: ListView(
              children: <Widget>[
                LogoImage(),
                TextAuth(),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.height * 0.05),
                  child: new TextFormField(
                      // controller: _controller,
                      // autofocus: false,
                      keyboardType: TextInputType.name,
                      // validator: (input) => !input.contains('@')
                      //     ? "Email Id should be valid"
                      //     : null,
                      onSaved: (input) => loginRequestModel.username = input,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.account_box),
                          contentPadding: const EdgeInsets.all(20.0),
                          labelText: 'Логин')),
                ),
                // _usernameField(),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.height * 0.05),
                  child: new TextFormField(
                      // controller: _controller2,
                      obscureText: true,
                      onSaved: (input) => loginRequestModel.password = input,
                      validator: (input) => input.length < 3
                          ? "Password should be more than 3 characters"
                          : null,
                      maxLength: 20,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.visibility_off),
                          contentPadding: const EdgeInsets.all(20.0),
                          labelText: 'Пароль')),
                ),
                // _passwordField(),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(24),
                  child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.06,
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
                                final snackBar = SnackBar(
                                    content: Text("Что то пошло не так"));
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
                                              CreatePersonalAreaPage()));
                                } else if (value.have) {
                                  return Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BottomPanel()));
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
              ],
            ),
          ),
        )));
  }

  bool validateAndSave() {
    final form = _globalFormKey.currentState;
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
