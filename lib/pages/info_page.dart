import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
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
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              child: SizedBox(
                height: 400,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Row(
                      children: [
                        new Text('О сервисе',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w300)),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 230),
                          child: IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AboutService()));
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        new Text('Социальные и экологические проекты',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w300)),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 10),
                          child: IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrgService()));
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        new Text('Поддержка',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w300)),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 225),
                          child: IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Support()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AboutService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('О сервисе',
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
        margin: EdgeInsets.all(24),
        alignment: Alignment.center,
        child: Text(
            '''Дорогие пользователи, приветствуем вас на сервисе обмена товаров Pinhome.+
          Если у вас есть вещи, которыми вы не пользуетесь, но хотели бы получить взамен их что-то полезное для себя, то вы можете найти это в данном сервисе. Основное правило экологичного образа жизни: ненужных вещей нет.+
          Попробуйте обменяться с другими пользователями вашими вещами. Если же вариант обмена вас не устраивает, вы всегда можете прибегнуть к помощи социальных и экологических проектов. Они отправят старые вещи на переработку или же отдадут их тем, кто в них нуждается.

          Основные принципы сообщества:
          - здесь не используются деньги. Все сделки проводятся на бартерной основе
          - если вы указали в объявлении, что вас не интересует обмен, это значит, что вы отдаете свою вещь безвозмездно. Вы не можете требовать что-то от другого пользователя взамен вашему предложению

          Если у вас возникли проблемы во время совершения сделки с другим пользователем, во время работы с приложением, то вы всегда можете обратиться в службу поддержки.
          Остальные вопросы, связанные с сотрудничеством или поддержкой проекта Pinhome просьба так же направлать на почту данного проекта.'''),
      ),
    );
  }
}

class OrgService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('Организации',
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
        margin: EdgeInsets.all(24),
        alignment: Alignment.center,
        child: Text(
            '''Здесь пока нет организаций. Но вы всегда можете написать нам в поддержку для добавления :)'''),
      ),
    );
  }
}

class Support extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('Поддержка',
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
        margin: EdgeInsets.all(24),
        alignment: Alignment.center,
        child: Text(
            '''По всем вопросам, связанным с работой приложения, бартерам или сотрудничеству, вы можете обращаться по адресу pinhome_support@gmail.com.'''),
      ),
    );
  }
}
