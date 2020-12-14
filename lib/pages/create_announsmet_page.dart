import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_announcement_service.dart';
import 'package:flutter_app_pinhome/model/categiries.dart';
import 'package:flutter_app_pinhome/model/crate_anouns_request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'bottom_panel.dart';

class CreateAnnounsmentPage extends StatefulWidget {
  @override
  _CreateAnnounsmentPageState createState() => _CreateAnnounsmentPageState();
}

class _CreateAnnounsmentPageState extends State<CreateAnnounsmentPage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool _autoValidate = false;
  bool _free = false;
  AnnouncementCreate model;
  Future<Categories> categoriesModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AnnouncementService service;
  Category _selectedItemCategory;
  File _file;
  List _selectedValues;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    _free = false;
    super.initState();
    model = new AnnouncementCreate();
    service = new AnnouncementService();
    categoriesModel = service.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: new Text("Добавление вещи"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomPanel()))),
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
                    pressedImage: _file != null
                        ? Image.file(_file)
                        : Image.asset("images/add_image.png"),
                    unpressedImage: Image.asset("images/add_image.png"),
                    onTap: () async {
                      var file = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      setState(() {
                        _file = file;
                      });
                      model.filePath = file.path;
                    },
                  ),
                ),
                _nameField(),
                _descrField(),
                _dropDownForItemCategory(),
                _freeCheckBox(),
                _wantField(),
                _dropDownForWant(),
                _cityField(),
                _submitButtonField(),
              ],
            ),
          ),
        )));
  }

  List<DropdownMenuItem<Category>> buildDropdownMenuItems(
      List<Category> categories) {
    List<DropdownMenuItem<Category>> items = List();
    for (Category category in categories) {
      items.add(
        DropdownMenuItem(
          value: category,
          child: Text(category.name),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<Category>> buildItems(List<Category> categories) {
    List<DropdownMenuItem<Category>> items = List();
    for (Category category in categories) {
      items.add(
        DropdownMenuItem(
          value: category,
          child: Text(category.name),
        ),
      );
    }
    return items;
  }

  onChangeDropDownForItemCategory(Category selectedCategory) {
    setState(() {
      _selectedItemCategory = selectedCategory;
      model.category = selectedCategory.id;
    });
  }

  Widget _dropDownForItemCategory() {
    return new Container(
      child: FutureBuilder(
          future: categoriesModel,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.99,
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.height * 0.05),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text("Выберете категорию вещи из объявления"),
                      value: _selectedItemCategory,
                      items: buildDropdownMenuItems(snapshot.data.category),
                      onChanged: onChangeDropDownForItemCategory,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.99,
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              );
            }
          }),
    );
  }

  Widget _dropDownForWant() {
    return Visibility(
      visible: !_free,
      child: new Container(
        child: FutureBuilder(
            future: categoriesModel,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.99,
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.height * 0.05),
                        child: buildDropDown(snapshot.data.category)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.99,
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }

  Widget buildDropDown(List<Category> list) {
    var data = list.map((category) => category.toJson()).toList();
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.99,
      height: MediaQuery.of(context).size.width * 0.55,
      child: MultiSelectFormField(
        title: Text("Категории желаемых вещей на обмен"),
        autovalidate: false,
        validator: (value) {
          if (value == null || value.length == 0) {
            return 'Список категорий не может быть пустым';
          } else if (value.length > 5) return 'Не более 5 категорий';
        },
        dataSource: data,
        textField: 'name',
        valueField: 'id',
        okButtonLabel: 'OK',
        cancelButtonLabel: 'CANCEL',
        required: !_free,
        initialValue: _selectedValues,
        onSaved: (value) {
          if (value == null) return;
          setState(() {
            _selectedValues = value;
            model.want = _selectedValues;
          });
        },
      ),
    );
  }

  Widget _freeCheckBox() {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.height * 0.05),
      child: Row(
        children: [
          Checkbox(
            value: _free,
            onChanged: (bool value) {
              setState(() {
                _free = value;
              });
            },
          ),
          Text('Отдам даром',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300))
        ],
      ),
    );
  }

  Widget _nameField() {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.height * 0.05),
      child: new TextFormField(
        onSaved: (input) => model.name = input,
        keyboardType: TextInputType.name,
        decoration: const InputDecoration(labelText: 'Название вещи'),
      ),
    );
    // });
  }

  Widget _descrField() {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.height * 0.05),
      child: new TextFormField(
        onSaved: (input) => model.description = input,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(labelText: 'Описание вещи'),
      ),
    );
    // });
  }

  Widget _wantField() {
    return Visibility(
      visible: !_free,
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.height * 0.05),
        child: new TextFormField(
          onSaved: (input) {
            model.strWant = input;
          },
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(labelText: 'Что вы хотите взамен'),
        ),
      ),
    );
    // });
  }

  Widget _cityField() {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.height * 0.05),
      child: new TextFormField(
        onSaved: (input) => model.city = input,
        keyboardType: TextInputType.streetAddress,
        decoration: const InputDecoration(labelText: 'Ваш город'),
      ),
    );
    // });
  }

  Widget _submitButtonField() {
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
                    return Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BottomPanel()));
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
        image: new AssetImage('images/logo_2.png'),
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.width * 0.35);
    return Container(margin: EdgeInsets.only(top: 100), child: image);
  }
}
