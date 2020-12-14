import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_announcement_service.dart';
import 'package:flutter_app_pinhome/model/announsment.dart';
import 'package:hexcolor/hexcolor.dart';

class ClosedAnnounsmentPage extends StatefulWidget {
  final int id;
  final String title;

  ClosedAnnounsmentPage({Key key, @required this.id, this.title})
      : super(key: key);

  @override
  _ClosedAnnounsmentPageState createState() => _ClosedAnnounsmentPageState();
}

class _ClosedAnnounsmentPageState extends State<ClosedAnnounsmentPage> {
  Future<Announcement> model;
  AnnouncementService service;

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
                                    ? "Хотел обменять на"
                                    : "Этот предмет отдается даром"),
                            Visibility(
                              visible: !snapshot.data.free,
                              child: TextRegular(
                                  text: !snapshot.data.free
                                      ? "Категории(я) : " +
                                          snapshot.data.want
                                              .map((e) => e.wantCat.name.trim())
                                              .join(", ")
                                      : ""),
                            ),
                            Visibility(
                                visible: !snapshot.data.free,
                                child: TextRegular(
                                    text: !snapshot.data.free
                                        ? "Описание : " + snapshot.data.strWant
                                        : "")),
                            TextBolt(text: "Местонахождение"),
                            TextRegular(text: snapshot.data.city),
                          ],
                        ));
                      }
                    }))));
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
