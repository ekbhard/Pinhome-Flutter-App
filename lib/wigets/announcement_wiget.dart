import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_announcement_service.dart';
import 'package:flutter_app_pinhome/model/all_announcements.dart';
import 'package:flutter_app_pinhome/pages/announcement_page.dart';
import 'package:hexcolor/hexcolor.dart';

class AnnouncementWidget extends StatefulWidget {
  const AnnouncementWidget({
    Key key,
    @required this.scrollController,
  }) : super(key: key);
  final ScrollController scrollController;

  @override
  _AnnouncementWidgetState createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  Future<List<AnnouncementElement>> model;
  bool isLoading = false;
  AnnouncementService service;

  // Announcement elements;

  @override
  void initState() {
    service = new AnnouncementService();
    model = service.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return FutureBuilder(
        future: model,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, int index) {
                      return getCard(snapshot.data[index]);
                    }));
          }
        });
  }

  Widget getCard(AnnouncementElement element) {
    var name = element.name;
    var want = element.want.first["str_want"];
    var picUrl = element.images.first.imagePath;
    return Container(
      height: 100,
      child: Card(
          elevation: 1.5,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                  onTap: () {
                    return Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnnounsmentPage(
                                  id: element.id,
                                  title: element.name,
                                )));
                  },
                  leading: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60 / 2),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(picUrl))),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: HexColor("#5F5F5F"),
                            fontSize: 16,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        want,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: HexColor("#5F5F5F"),
                            fontSize: 12,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  )))),
    );
  }
}
