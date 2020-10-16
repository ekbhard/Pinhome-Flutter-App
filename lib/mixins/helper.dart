import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/blocs/auth_form_bloc.dart';

class Helper {
  Widget errorMessage(AuthFormBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.errorMessage,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data, style: TextStyle(color: Colors.red));
        }
        return Text('');
      },
    );
  }
}
