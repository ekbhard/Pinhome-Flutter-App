import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/services/auth_service.dart';
import 'package:flutter_app_pinhome/services/personal_area_service.dart';
import 'package:rxdart/rxdart.dart';

import '../mixins/validation_mixin.dart';

class PersonalAreaFormBloc with ValidationMixin {
  final _surname = new BehaviorSubject<String>();
  final _name = new BehaviorSubject<String>();
  final _errorMessage = new BehaviorSubject<String>();

  // getters: Changers
  Function(String) get changeSurname {
    // addError(null);
    return _surname.sink.add;
  }

  Function(String) get changeName {
    // addError(null);
    return _name.sink.add;
  }

  Function(String) get addError => _errorMessage.sink.add;

  // getters: Add stream
  Stream<String> get surname => _surname.stream.transform(validatorEmail);

  Stream<String> get name => _name.stream.transform(validatorPassword);

  Stream<String> get errorMessage => _errorMessage.stream;

  Stream<bool> get submitValidForm => Rx.combineLatest3(
        surname,
        name,
        errorMessage,
        (e, p, er) => true,
      );

  var personalAreaInfo;

  dynamic createPersonalArea(BuildContext context) async {
    personalAreaInfo = PersonalAreaService();

    final res = await personalAreaInfo.create(_surname.value, _name.value);

    if (res['status'] != 201) {
      addError(res['message']);
    } else {
      Navigator.pushNamed(context, '/AuthPage');
    }
  }

  // close streams
  dispose() {
    _surname.close();
    _name.close();
    _errorMessage.close();
  }
}
