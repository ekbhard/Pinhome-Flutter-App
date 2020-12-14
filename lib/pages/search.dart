import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_announcement_service.dart';
import 'package:flutter_app_pinhome/model/all_announcements.dart';
import 'package:flutter_app_pinhome/model/categiries.dart';
import 'package:flutter_app_pinhome/pages/show_announcement_page.dart';
import 'package:hexcolor/hexcolor.dart';

import 'bottom_panel.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  AnnouncementService service;
  Future<Categories> categoriesModel;
  Category category;
  Future<List<AnnouncementElement>> model;
  GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    service = new AnnouncementService();
    categoriesModel = service.getCategories();
    model = service.search("", "");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: new Text('Поиск'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomPanel()))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Container(
          width: MediaQuery.of(context).size.width * 0.99,
          height: MediaQuery.of(context).size.height * 0.8,
          alignment: Alignment.center,
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(8),
                child: Row(
                  children: [
                    barWidget(),
                    categoriesButton(context),
                    buildCancelButton()
                  ],
                ),
              ),
              getBody()
            ],
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<Category>> popupMenuEntryBuilder(
      List<Category> categories) {
    var list = List<PopupMenuEntry<Category>>();
    for (Category category in categories) {
      list.add(
        PopupMenuItem(
          value: category,
          child: Text(category.name),
        ),
      );
    }
    list.add(
      PopupMenuDivider(
        height: 10,
      ),
    );
    return list;
  }

  Widget buildCancelButton() {
    return new IconButton(
        iconSize: MediaQuery.of(context).size.height * 0.05,
        icon: Icon(Icons.clear),
        onPressed: () {
          category = null;
          model = service.search("", "");
        });
  }

  Widget categoriesButton(BuildContext context) {
    return new Container(
      child: FutureBuilder(
          future: categoriesModel,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                child: Center(
                  child: PopupMenuButton<Category>(
                    onSelected: (Category category) {
                      onChangeDropDownForWantCategory(category);
                    },
                    icon: Icon(Icons.filter_list,
                        size: MediaQuery.of(context).size.height * 0.05),
                    itemBuilder: (BuildContext context) {
                      return popupMenuEntryBuilder(snapshot.data.category);
                    },
                  ),
                ),
              );
            }
          }),
    );
  }

  onChangeDropDownForWantCategory(Category selectedCategory) {
    setState(() {
      category = selectedCategory;
      model = service.search("", selectedCategory.id.toString());
    });
  }

  Widget getBody() {
    return FutureBuilder(
        future: model,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                width: MediaQuery.of(context).size.width * 0.99,
                height: MediaQuery.of(context).size.height * 0.8,
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
    var want =
        element.strWant != null ? element.strWant : "Эта вещь отдается даром";
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

  Widget barWidget() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: MediaQuery.of(context).size.width * 0.65,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.only(left: 16),
                child: Form(
                  key: _globalFormKey,
                  child: new TextFormField(
                    autofocus: true,
                    onFieldSubmitted: (value) {
                      setState(() {
                        model = service.search(value,
                            category != null ? category.id.toString() : "");
                      });
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.search, size: 20, color: Colors.black),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: HexColor("C9C9C9")),
                        border: InputBorder.none),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
