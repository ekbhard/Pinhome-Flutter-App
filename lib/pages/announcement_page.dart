import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_announcement_service.dart';
import 'package:flutter_app_pinhome/model/announsment.dart';
import 'package:flutter_app_pinhome/wigets/custom_dialog.dart';
import 'package:hexcolor/hexcolor.dart';

class AnnounsmentPage extends StatefulWidget {
  final int id;
  final String title;

  AnnounsmentPage({Key key, @required this.id, this.title}) : super(key: key);

  @override
  _AnnounsmentPageState createState() => _AnnounsmentPageState();
}

class _AnnounsmentPageState extends State<AnnounsmentPage> {
  Future<Announcement> model;
  AnnouncementService service;
  bool _free;

  @override
  void initState() {
    super.initState();
    service = new AnnouncementService();
    model = service.getById(widget.id);
    // loadImageFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text(widget.title),
        ),
        body: Center(
            child: Container(
                child: FutureBuilder<Announcement>(
                    future: model,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Container(
                            child: ListView(
                          children: [
                            ItemImage(
                              imageUrl: snapshot.data.images.first.imagePath,
                            ),
                            TextBolt(text: "Описание"),
                            TextRegular(text: snapshot.data.description),
                            TextBolt(
                                text: !snapshot.data.free
                                    ? "Хочу обменять на"
                                    : "Этот предмет отдается бесплатно"),
                            Visibility(
                              visible: !snapshot.data.free,
                              child: TextRegular(
                                  text: !snapshot.data.free
                                      ? snapshot.data.want.first.wantCat.name
                                      : ""),
                            ),
                            Visibility(
                                visible: !snapshot.data.free,
                                child: TextRegular(
                                    text: !snapshot.data.free
                                        ? snapshot.data.want.first.strWant
                                        : "")),
                            TextBolt(text: "Местонахождение"),
                            TextRegular(text: snapshot.data.city),
                            _variantsButton(),
                            _editButtonField(),
                            _deleteButton(snapshot.data.id)
                          ],
                        ));
                      }
                    }))));
  }

  _createAlertDialog(BuildContext context, int itemId) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Выберите причину"),
            actions: <Widget>[CustomDialog(itemId: itemId)],
          );
        });
  }

  Widget _variantsButton() {
    return Container(
      alignment: Alignment.center,
      child: ButtonTheme(
          minWidth: 250,
          height: 40,
          child: RaisedButton(
            onPressed: () {},
            color: Colors.amber[300],
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            child: Text('Варианты обмена',
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

  Widget _editButtonField() {
    return Container(
      alignment: Alignment.center,
      child: ButtonTheme(
          minWidth: 250,
          height: 40,
          child: RaisedButton(
            onPressed: () {},
            color: Colors.amber[300],
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            child: Text('Редактировать',
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

  Widget _deleteButton(int itemId) {
    return Container(
        alignment: Alignment.center,
        child: ButtonTheme(
            minWidth: 250,
            height: 40,
            child: RaisedButton(
              // padding: EdgeInsets.all(50),
              onPressed: () {
                _createAlertDialog(context, itemId);
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 3, color: Colors.amber[300]),
                  borderRadius: new BorderRadius.circular(10.0)),
              child: Text('Снять с публикации',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w300)),
            )));
  }
}

class ItemImage extends StatelessWidget {
  final String imageUrl;

  const ItemImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image image = Image(image: NetworkImage(imageUrl), fit: BoxFit.cover);
    return Container(
      margin: EdgeInsets.all(5),
      child: image,
      width: MediaQuery.of(context).size.width * 0.99,
      height: MediaQuery.of(context).size.height * 0.50,
    );
  }
}

class TextBolt extends StatelessWidget {
  final String text;

  const TextBolt({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(text,
          textDirection: TextDirection.ltr,
          style: TextStyle(
              color: HexColor("#5F5F5F"),
              fontFamily: 'Open Sans',
              fontSize: 20,
              fontWeight: FontWeight.w700)),
    );
  }
}

class TextRegular extends StatelessWidget {
  final String text;

  const TextRegular({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(text,
          textDirection: TextDirection.ltr,
          style: TextStyle(
              color: HexColor("#5F5F5F"),
              fontFamily: 'Open Sans',
              fontSize: 15,
              fontWeight: FontWeight.w300)),
    );
  }
}
