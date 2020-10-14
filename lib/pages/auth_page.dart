import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/blocs/form_bloc.dart';
import 'package:flutter_app_pinhome/providers/provider.dart';
import '../mixins/validation_mixin.dart';

class AuthPage extends StatefulWidget {
  @override
  createState() {
    return _AuthPage();
  }
}

class _AuthPage extends State<AuthPage> with ValidationMixin {
  // final FormBloc formBloc = Provider.of(context);
  final _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";
  bool checked = false;

  @override
  Widget build(BuildContext context) {
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
                usernameField(),
                passwordField(),
                button()
              ],
            ),
          ),
        ));
  }

  Widget usernameField() {
    return TextFormField(
      // keyboardType: TextInputType.,
      // validator: validateEmail,
      onSaved: (value) {
        setState(() {
          username = value;
        });
      },
      decoration: const InputDecoration(
          icon: Icon(Icons.account_box),
          contentPadding: const EdgeInsets.all(20.0),
          labelText: 'Name',
          hintText: 'someone@company.com'),
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      // validator: validatePassword,
      onSaved: (value) {
        setState(() {
          password = value;
        });
      },
      decoration: const InputDecoration(
          icon: Icon(Icons.visibility_off),
          contentPadding: const EdgeInsets.all(20.0),
          labelText: 'Password',
          hintText: 'Enter password'),
    );
  }

  // Widget button() {
  //   return Container(
  //     alignment: Alignment.bottomRight,
  //     margin: EdgeInsets.only(top: 100.0, left: 130.0),
  //     child: Row(
  //       children: <Widget>[
  //         Text(
  //           'Login',
  //           style: TextStyle(
  //             color: Colors.blue[400],
  //             fontSize: 20.0,
  //           ),
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.arrow_forward),
  //           splashColor: Colors.pink[300],
  //           onPressed: () {
  //             if (_formKey.currentState.validate()) {
  //               // print
  //               _formKey.currentState.save();
  //               print('Здравствуйте, $username');
  //             }
  //           },
  //           color: Colors.blue,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget button() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(24),
      child: Row(
        children: <Widget>[
          ButtonTheme(
              minWidth: 250,
              height: 40,
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // print
                    _formKey.currentState.save();
                    print('Здравствуйте, $username');
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
        ],
      ),
    );
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

// class AuthPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: Center(
//           child: Container(
//             alignment: Alignment.center,
//             color: Colors.white,
//             child: ListView(
//               // mainAxisAlignment: MainAxisAlignment.center,
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[LogoImage(), TextAuth(), FormScreen()],
//             ),
//           ),
//         ));
//   }
// }
//
//
//

//
//
//
// // class FormScreenState extends State<FormScreen> {
// //   String _name;
// //   String _password;
// //
// //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// //
//   Widget _buildName() {
//     return TextFormField(
//       decoration: InputDecoration(
//           contentPadding: const EdgeInsets.all(20.0), labelText: 'Name'),
//       maxLength: 5,
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Name is Required';
//         }
//
//         return null;
//       },
//       onSaved: (String value) {
//         _name = value;
//       },
//     );
//   }
//
//
//
//   Widget _buildPassword() {
//     return TextFormField(
//       obscureText: true,
//       decoration: InputDecoration(
//           contentPadding: const EdgeInsets.all(20.0), labelText: 'Password'),
//       keyboardType: TextInputType.visiblePassword,
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Password is Required';
//         }
//
//         return null;
//       },
//       onSaved: (String value) {
//         _password = value;
//       },
//     );
//   }
//
// @override
// Widget build(BuildContext context) {
//   return Container(
//     // margin: EdgeInsets.all(24),
//     child: Form(
//       key: _formKey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           _buildName(),
//           _buildPassword(),
//           SizedBox(height: 10),
//           ButtonTheme(
//               minWidth: 250,
//               height: 40,
//               child: RaisedButton(
//                 onPressed: () {
//                   if (_formKey.currentState.validate()) {
//                     // print
//                     _formKey.currentState.save();
//                     print('Здравствуйте, $username');
//                   }
//                 },
//                 color: Colors.amber[300],
//                 shape: RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(10.0)),
//                 child: Text('Войти',
//                     textDirection: TextDirection.ltr,
//                     style: TextStyle(
//                         decoration: TextDecoration.none,
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontFamily: 'Open Sans',
//                         fontWeight: FontWeight.w300)),
//               )),
//         ],
//       ),
//     ),
//   );
// }
