import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/model/reference_model.dart';
import 'package:hexcolor/hexcolor.dart';

class EcoPoject extends StatelessWidget {
  final List<Charity> charities;

  const EcoPoject({Key key, this.charities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: new Text('Проекты',
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
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Данные социальные и экологические проекты помогут дать вторую жизнь вашим вещам, если вы не смогли или не захотели обменять их на сервисе Pinhome.',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w300)),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.99,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                        itemCount: charities.length,
                        itemBuilder: (context, int index) {
                          return ListTile(
                              title:
                                  StackWidetSample(charity: charities[index]));
                        })),
              ],
            )));
  }
}

class StackWidetSample extends StatelessWidget {
  final Charity charity;

  const StackWidetSample({Key key, this.charity}) : super(key: key);

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
              charity.imagesCharities.first.imagePath,
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.99,
              fit: BoxFit.cover,
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                charity.name,
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
                        builder: (context) => Project(
                              charity: charity,
                            )));
              },
            ),
          )
        ],
      )),
    );
  }
}

class Project extends StatelessWidget {
  final Charity charity;

  const Project({Key key, this.charity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: new Text('Проекты',
              textAlign: TextAlign.center,
              // textDirection: TextDirection.ltr,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700)),
        ),
        body: Container(
            margin: EdgeInsets.only(top: 70),
            child: ListView(
              children: [
                Row(children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(charity.name,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                color: HexColor("#FEB904"),
                                fontFamily: 'PTSans',
                                fontSize: 25,
                                fontWeight: FontWeight.w700)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(charity.charitiesAddress.first.address,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w300)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(charity.charitiesContacts.first.contact,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w300)),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        charity.imagesCharities.first.imagePath,
                        alignment: Alignment.bottomCenter,
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('О проекте:',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(charity.description,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w300)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Социальные сети:',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w700)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(charity.charitiesSocialNetworks.first.socialNetworks,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w300)),
                ),
              ],
            )));
  }
}
