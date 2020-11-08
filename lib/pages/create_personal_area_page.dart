import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_personal_area_service.dart';
import 'package:flutter_app_pinhome/model/personal_area_model.dart';
import 'package:flutter_app_pinhome/pages/personal_area_page.dart';
import 'package:flutter_app_pinhome/services/utills.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagebutton/imagebutton.dart';

class CreatePersonalAreaPage extends StatefulWidget {
  @override
  _CreatePersonalAreaPageState createState() => _CreatePersonalAreaPageState();
}

class _CreatePersonalAreaPageState extends State<CreatePersonalAreaPage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool _autoValidate = false;
  PersonalAreaRequestModel personalAreaRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PersonalAreaService personalAreaService;

  @override
  void initState() {
    super.initState();
    personalAreaRequestModel = new PersonalAreaRequestModel();
    personalAreaService = new PersonalAreaService();
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
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                LogoImage(),
                TextAuth(),
                _usernameField(),
                _surnameField(),
                _patronymicField(),
                _geolocationField(),
                _emailField(),
                _phoneNumberField(),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: ImageButton(
                    children: <Widget>[],
                    width: 78,
                    height: 57,
                    paddingTop: 5,
                    pressedImage: Image.asset(
                      "images/add_image.png",
                    ),
                    unpressedImage: Image.asset("images/add_image.png"),
                    onTap: () async {
                      var file = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      personalAreaRequestModel.filePath = file.path;
                    },
                  ),
                ),
                // FloatingActionButton(
                //   onPressed: () async {
                //     var file = await ImagePicker.pickImage(
                //         source: ImageSource.gallery);
                //     personalAreaRequestModel.filePath = file.path;
                //   },
                //   child: Icon(Icons.add_a_photo),
                // ),
                _buttonField(),
              ],
            ),
          ),
        )));
  }

  Widget _buttonAvatar(BuildContext context) {
    return ImageButton(
      children: <Widget>[],
      width: 91,
      height: 36,
      paddingTop: 5,
      pressedImage: Image.asset(
        "images/add_image.png",
      ),
      unpressedImage: Image.asset("images/add_image.png"),
      onTap: () async {
        var file = await ImagePicker.pickImage(source: ImageSource.gallery);
        personalAreaRequestModel.filePath = file.path;
      },
    );
  }

  Widget _usernameField() {
    return new TextFormField(
      onSaved: (input) => personalAreaRequestModel.name = input,
      keyboardType: TextInputType.name,
      validator: (name) {
        Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(name))
          return 'Invalid username';
        else
          return null;
      },
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0), labelText: 'Имя'),
    );
    // });
  }

  Widget _surnameField() {
    return new TextFormField(
      onSaved: (input) => personalAreaRequestModel.surname = input,
      keyboardType: TextInputType.name,
      validator: (name) {
        Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(name))
          return 'Invalid surname';
        else
          return null;
      },
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0), labelText: 'Фамилия'),
    );
    // });
  }

  Widget _patronymicField() {
    return new TextFormField(
      onSaved: (input) => personalAreaRequestModel.patronymic = input,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0), labelText: 'Отчество'),
    );
    // });
  }

  Widget _geolocationField() {
    return new TextFormField(
      onSaved: (input) => personalAreaRequestModel.geolocation = input,
      keyboardType: TextInputType.streetAddress,
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          labelText: 'Расположение'),
    );
    // });
  }

  Widget _phoneNumberField() {
    return new TextFormField(
      onSaved: (input) => personalAreaRequestModel.phoneNumber = input,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0), labelText: 'Телефон'),
    );
    // });
  }

  Widget _emailField() {
    return new TextFormField(
      onSaved: (input) => personalAreaRequestModel.email = input,
      keyboardType: TextInputType.emailAddress,
      validator: (email) =>
          EmailValidator.validate(email) ? null : "Invalid email address",
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          labelText: 'Электронная почта'),
    );
    // });
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
                print(personalAreaRequestModel.toJson());
                setState(() {
                  isApiCallProcess = true;
                });
                personalAreaService = new PersonalAreaService();
                personalAreaService
                    .create(personalAreaRequestModel)
                    .then((value) {
                  if (value.status == 200) {
                    return Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PersonalAreaPage()));
                  } else {
                    final snackBar = SnackBar(
                        content: Text("Создание личного кабинета не успешно"));
                    scaffoldKey.currentState.showSnackBar(snackBar);
                  }
                });
              }
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
