import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/model/reference_model.dart';

class ServiceAnsSupportPage extends StatelessWidget {
  final AboutService service;

  const ServiceAnsSupportPage({Key key, this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: new Text(service.name,
              textAlign: TextAlign.center,
              // textDirection: TextDirection.ltr,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700)),
        ),
        body: ListView(children: [
          Container(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                service.imagePath,
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.99,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(service.description,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w300)),
          )
        ]));
  }
}
