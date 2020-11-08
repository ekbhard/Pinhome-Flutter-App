import 'dart:async';
import 'dart:convert';

import 'package:flutter_app_pinhome/model/announcement.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AnnouncementService {
  final storage = new FlutterSecureStorage();
  String url = "https://backend-pin-home-server.site";

  Future<Announcement> get() async {
    String loginUrl = "/my_announcements/all_active";
    String value = await storage.read(key: "token");
    Map<String, String> headers = {'x-access-token': value};
    final response = await http.get(url + loginUrl, headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return Announcement.fromJson(json.decode(response.body));
  }
}
