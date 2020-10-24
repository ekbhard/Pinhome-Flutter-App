import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_personal_area_service.dart';
import 'package:flutter_app_pinhome/model/personal_area_model.dart';
import 'package:image_picker/image_picker.dart';

class PersonalAreaPage extends StatefulWidget {
  @override
  _PersonalAreaPageState createState() => _PersonalAreaPageState();
}

class _PersonalAreaPageState extends State<PersonalAreaPage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  PersonalAreaRequestModel personalAreaRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PersonalAreaService personalAreaService;

  @override
  void initState() {
    super.initState();
    personalAreaRequestModel = new PersonalAreaRequestModel();
    personalAreaService = new PersonalAreaService();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return (
  //     child: _uiSetup(context),
  //     inAsyncCall: isApiCallProcess,
  //     opacity: 0.3,
  //   );
  // }

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
            key: globalFormKey,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                LogoImage(),
                TextAuth(),
                new TextFormField(
                  onSaved: (input) => personalAreaRequestModel.name = input,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      contentPadding: const EdgeInsets.all(20.0),
                      labelText: 'Имя'),
                ),
                _surnameField(),
                _patronymicField(),
                _geolocationField(),
                _emailField(),
                _phoneNumberField(),
                FloatingActionButton(
                  onPressed: () async {
                    var file = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    personalAreaRequestModel.file = file.path;
                    // var res = await uploadImage(file.path, widget.url);
                    // setState(() {
                    //   state = res;
                    //   print(res);
                    // });
                  },
                  child: Icon(Icons.add_a_photo),
                ),
                _buttonField(),
              ],
            ),
          ),
        )));
  }

  Widget _usernameField() {
    return new TextFormField(
      onSaved: (input) => personalAreaRequestModel.name = input,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0), labelText: 'Имя'),
    );
    // });
  }

  Widget _surnameField() {
    return new TextFormField(
      onSaved: (input) => personalAreaRequestModel.surname = input,
      keyboardType: TextInputType.name,
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
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          labelText: 'Расположение'),
    );
    // });
  }

  Widget _phoneNumberField() {
    return new TextFormField(
      onSaved: (input) => personalAreaRequestModel.geolocation = input,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0), labelText: 'Телефон'),
    );
    // });
  }

  Widget _emailField() {
    return new TextFormField(
      onSaved: (input) => personalAreaRequestModel.email = input,
      keyboardType: TextInputType.name,
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
                personalAreaService.create(personalAreaRequestModel);
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
