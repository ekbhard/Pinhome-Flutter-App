import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/services/auth_service.dart';
import 'package:rxdart/rxdart.dart';

import '../mixins/validation_mixin.dart';

class AuthFormBloc with ValidationMixin {
  final _username = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();
  final _errorMessage = new BehaviorSubject<String>();

  // getters: Changers
  Function(String) get changeUsername {
    addError(null);
    return _username.sink.add;
  }

  Function(String) get changePassword {
    addError(null);
    return _password.sink.add;
  }

  Function(String) get addError => _errorMessage.sink.add;

  // getters: Add stream
  Stream<String> get username => _username.stream.transform(validatorEmail);

  Stream<String> get password => _password.stream.transform(validatorPassword);

  Stream<String> get errorMessage => _errorMessage.stream;

  Stream<bool> get submitValidForm => Rx.combineLatest3(
        username,
        password,
        errorMessage,
        (e, p, er) => true,
      );

  var authInfo;

  dynamic register(BuildContext context) async {
    authInfo = AuthService();

    final res = await authInfo.register(_username.value, _password.value);

    if (res['status'] != 201) {
      addError(res['message']);
    } else {
      Navigator.pushNamed(context, '/AuthPage');
    }
  }

  // login
  dynamic login(BuildContext context) async {
    authInfo = AuthService();

    final Map<Object, Object> res =
        await authInfo.login(_username.value, _password.value);
    if (res['status'] != 200) {
      addError(res['message']);
    } else {
      AuthService.setToken(res['cookies']);
      Navigator.pushNamed(context, '/PersonPage');
    }
  }

  // close streams
  dispose() {
    _username.close();
    _password.close();
    _errorMessage.close();
  }
}
