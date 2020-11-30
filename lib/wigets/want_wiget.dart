import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_announcement_service.dart';
import 'package:flutter_app_pinhome/model/want_tab.dart';
import 'package:hexcolor/hexcolor.dart';

class WantAnnouncementWidget extends StatefulWidget {
  const WantAnnouncementWidget({
    Key key,
    @required this.scrollController,
  }) : super(key: key);
  final ScrollController scrollController;

  @override
  _WantAnnouncementWidgetState createState() => _WantAnnouncementWidgetState();
}

class _WantAnnouncementWidgetState extends State<WantAnnouncementWidget> {
  Future<List<WantTab>> model;
  bool isLoading = false;
  AnnouncementService service;

  // Announcement elements;

  @override
  void initState() {
    service = new AnnouncementService();
    model = service.getWantTab();
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

  Widget getCard(WantTab element) {
    var want = element.strWant;
    return Container(
      width: MediaQuery.of(context).size.width * 0.99,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Card(
          elevation: 1.5,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                  onTap: () {},
                  title: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                want,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: HexColor("#5F5F5F"),
                                    fontSize: 16,
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Похожие объявления",
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: HexColor("#5F5F5F"),
                                    fontSize: 12,
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.clear),
                          iconSize: MediaQuery.of(context).size.height * 0.05,
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.create),
                          iconSize: MediaQuery.of(context).size.height * 0.05,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )))),
    );
  }
}
