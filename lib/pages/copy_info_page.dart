import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/info_service.dart';
import 'package:flutter_app_pinhome/model/reference_model.dart';

import 'eco_poject_page.dart';
import 'service_ans_support_page.dart';

class InfoCpy extends StatefulWidget {
  @override
  _InfoCpyState createState() => _InfoCpyState();
}

class _InfoCpyState extends State<InfoCpy> {
  Future<Reference> model;

  @override
  void initState() {
    model = new InfoService().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('Справка',
            textAlign: TextAlign.center,
            // textDirection: TextDirection.ltr,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700)),
      ),
      body: new Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 50),
        child: FutureBuilder(
            future: model,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView(
                  children: <Widget>[
                    StackWidetSample(
                        imageUrl: snapshot.data.reference.charity.imagePath,
                        text: snapshot.data.reference.charity.name,
                        id: snapshot.data.reference.charity.id,
                        charity: snapshot.data.reference.charity.charities),
                    StackWidet(
                      imageUrl: snapshot.data.reference.support.imagePath,
                      text: snapshot.data.reference.support.name,
                      id: snapshot.data.reference.support.id,
                      service: snapshot.data.reference.support,
                    ),
                    StackWidet(
                      imageUrl: snapshot.data.reference.aboutService.imagePath,
                      text: snapshot.data.reference.aboutService.name,
                      id: snapshot.data.reference.aboutService.id,
                      service: snapshot.data.reference.aboutService,
                    )
                  ],
                );
              }
            }),
      ),
    );
  }
}

class StackWidetSample extends StatelessWidget {
  final String imageUrl;
  final String text;
  final int id;
  final List<Charity> charity;

  const StackWidetSample(
      {Key key, this.imageUrl, this.text, this.id, this.charity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.network(
              imageUrl,
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.99,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              )),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width * 0.99,
            height: MediaQuery.of(context).size.height * 0.3,
            child: FlatButton(
              onPressed: () {
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EcoPoject(
                              charities: charity,
                            )));
              },
            ),
          )
        ],
      )),
    );
  }
}

class StackWidet extends StatelessWidget {
  final String imageUrl;
  final String text;
  final int id;
  final AboutService service;

  const StackWidet({Key key, this.imageUrl, this.text, this.id, this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.network(
              imageUrl,
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.99,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              )),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width * 0.99,
            height: MediaQuery.of(context).size.height * 0.3,
            child: FlatButton(
              onPressed: () {
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ServiceAnsSupportPage(
                              service: service,
                            )));
              },
            ),
          )
        ],
      )),
    );
  }
}
