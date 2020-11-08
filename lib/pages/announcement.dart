import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pinhome/api/api_announcement_service.dart';
import 'package:flutter_app_pinhome/model/announcement.dart';

class AnnouncementWidget extends StatefulWidget {
  @override
  _AnnouncementWidgetState createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  Future<Announcement> model;

  @override
  void initState() {
    model =  AnnouncementService().get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
