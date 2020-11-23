import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/close_service.dart';
import 'package:flutter_app_pinhome/model/close_model.dart';
import 'package:flutter_app_pinhome/model/reason_close.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomDialog extends StatefulWidget {
  final int userId;

  const CustomDialog({Key key, this.userId}) : super(key: key);

  @override
  _DaialogState createState() => _DaialogState();
}

class _DaialogState extends State<CustomDialog> {
  Future<List<ReasonClose>> model;
  CloseService service;
  bool isLoading = false;

  @override
  void initState() {
    service = new CloseService();
    model = service.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    return FutureBuilder(
        future: model,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                // alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.50,
                height: MediaQuery.of(context).size.height * 0.30,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, int index) {
                      return _button(snapshot.data[index]);
                    }));
          }
        });
  }

  Widget _button(ReasonClose element) {
    var name = element.name;
    var reasonCloseId = element.id;
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width * 0.48,
            height: MediaQuery.of(context).size.height * 0.05,
            child: RaisedButton(
              // padding: EdgeInsets.all(50),
              onPressed: () {
                service.delete(Close.fromReason(reasonCloseId), widget.userId);
              },
              color: Colors.white,
              // shape: RoundedRectangleBorder(
              //     side: BorderSide(width: 3, color: Colors.amber[300]),
              //     borderRadius: new BorderRadius.circular(10.0)),
              child: Text(name,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: HexColor("#5F5F5F"),
                      fontSize: 18,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w300)),
            )));
  }
}
