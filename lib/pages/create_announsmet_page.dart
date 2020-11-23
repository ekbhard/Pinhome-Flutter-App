import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_announcement_service.dart';
import 'package:flutter_app_pinhome/model/crate_anouns_request.dart';
import 'package:flutter_app_pinhome/pages/personal_area_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagebutton/imagebutton.dart';

class CreateAnnounsmentPage extends StatefulWidget {
  @override
  _CreateAnnounsmentPageState createState() => _CreateAnnounsmentPageState();
}

class _CreateAnnounsmentPageState extends State<CreateAnnounsmentPage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool _autoValidate = false;
  AnnouncementCreate model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AnnouncementService service;

  @override
  void initState() {
    super.initState();
    model = new AnnouncementCreate();
    service = new AnnouncementService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: new Text("Добавление товара"),
        ),
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
                      model.filePath = file.path;
                    },
                  ),
                ),
                _nameField(),
                _descrField(),
                _wantField(),
                _addressField(),
                _cityField(),
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
        model.filePath = file.path;
      },
    );
  }

  Widget _nameField() {
    return new TextFormField(
      onSaved: (input) => model.name = input,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          labelText: 'Название товара'),
    );
    // });
  }

  Widget _descrField() {
    return new TextFormField(
      onSaved: (input) => model.description = input,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          labelText: 'Описание товара'),
    );
    // });
  }

  Widget _wantField() {
    var namesGrowable = new List<Want>();
    return new TextFormField(
      onSaved: (input) {
        namesGrowable.add(Want(1, input));
        model.want = namesGrowable;
      },
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          labelText: 'Что вы хотите взамен'),
    );
    // });
  }

  Widget _addressField() {
    return new TextFormField(
      onSaved: (input) => model.address = input,
      keyboardType: TextInputType.streetAddress,
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          labelText: 'Расположение'),
    );
    // });
  }

  Widget _cityField() {
    return new TextFormField(
      onSaved: (input) => model.city = input,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
          contentPadding: const EdgeInsets.all(20.0), labelText: 'Ваш город'),
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
                print(model.toJson());
                setState(() {
                  isApiCallProcess = true;
                });
                service = new AnnouncementService();
                service.create(model).then((value) {
                  if (value.status == 200) {
                    return Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PersonalAreaPage()));
                  } else {
                    final snackBar = SnackBar(
                        content: Text("Создание объявления не успешно"));
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
