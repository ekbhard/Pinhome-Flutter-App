import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_announcement_service.dart';
import 'package:flutter_app_pinhome/model/recommended.dart';
import 'package:flutter_app_pinhome/pages/show_announcement_page.dart';
import 'package:hexcolor/hexcolor.dart';

class VariantsExchangePage extends StatefulWidget {
  final int id;

  const VariantsExchangePage({Key key, this.id}) : super(key: key);

  @override
  _VariantsExchangePageState createState() => _VariantsExchangePageState();
}

class _VariantsExchangePageState extends State<VariantsExchangePage> {
  Future<List<Result>> model;
  bool isLoading = false;
  AnnouncementService service;

  // Announcement elements;

  @override
  void initState() {
    service = new AnnouncementService();
    model = service.geRecommended(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Варианты обмена на вещь"),
        ),
        body: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
            child: getBody()));
  }

  Widget getBody() {
    return FutureBuilder(
        future: model,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, int index) {
                        return getCard(snapshot.data[index]);
                      }));
            } else {
              return Container(
                child: Center(
                    child: Text(
                        "К сожалению, для этой вещи не нашлось вариантов обмена.\nПопробуйте найти подходящие категрии в поиске.")),
              );
            }
          } else
            return Container();
        });
  }

  Widget getCard(Result element) {
    var name = element.name;
    var want = element.want.length != 0
        ? element.want.first["str_want"]
        : "Эта вещь отдается даром";
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
                            builder: (context) => ShowAnnounsmentPage(
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
