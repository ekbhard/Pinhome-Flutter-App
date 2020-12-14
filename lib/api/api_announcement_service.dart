import 'dart:async';
import 'dart:convert';

import 'package:flutter_app_pinhome/model/all_announcements.dart';
import 'package:flutter_app_pinhome/model/announsment.dart';
import 'package:flutter_app_pinhome/model/categiries.dart';
import 'package:flutter_app_pinhome/model/crate_anouns_request.dart';
import 'package:flutter_app_pinhome/model/recommended.dart';
import 'package:flutter_app_pinhome/model/want_tab.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AnnouncementService {
  final storage = new FlutterSecureStorage();
  String url = "https://backend-pin-home-server.site";

  Future<List<AnnouncementElement>> get() async {
    String loginUrl = "/api/my_announcements/all_active";
    String value = await storage.read(key: "token");
    Map<String, String> headers = {'x-access-token': value};
    final response = await http.get(url + loginUrl, headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return AnnouncementAll.fromJson(json.decode(response.body)).announcement;
  }

  Future<List<AnnouncementElement>> search(
      String query, String category) async {
    String loginUrl =
        "/api/search_announcements?query=" + query + "&category=" + category;
    String value = await storage.read(key: "token");
    Map<String, String> headers = {'x-access-token': value};
    final response = await http.get(url + loginUrl, headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return AnnouncementAll.fromJson(json.decode(response.body)).announcement;
  }

  Future<List<Result>> geRecommended(int id) async {
    String loginUrl = "/api/recommended_for_want/" + id.toString();
    String value = await storage.read(key: "token");
    Map<String, String> headers = {'x-access-token': value};
    final response = await http.get(url + loginUrl, headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return Recommended.fromJson(json.decode(response.body)).result;
  }

  Future<List<WantTab>> getWantTab() async {
    String loginUrl = "/api/wants_for_current_user";
    String value = await storage.read(key: "token");
    Map<String, String> headers = {'x-access-token': value};
    final response = await http.get(url + loginUrl, headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    List<WantTab> list = List<WantTab>.from(
        json.decode(response.body).map((x) => WantTab.fromJson(x)));
    return list;
  }

  Future<List<AnnouncementElement>> getClosed() async {
    String loginUrl = "/api/my_announcements/closed";
    String value = await storage.read(key: "token");
    Map<String, String> headers = {'x-access-token': value};
    final response = await http.get(url + loginUrl, headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return AnnouncementAll.fromJson(json.decode(response.body)).announcement;
  }

  Future<Announcement> getById(int id) async {
    String loginUrl = "/api/get_announcement/" + id.toString();
    String value = await storage.read(key: "token");
    Map<String, String> headers = {'x-access-token': value};
    final response = await http.get(url + loginUrl, headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return Announcement.fromJson(json.decode(response.body));
  }

  Future<Categories> getCategories() async {
    String loginUrl = "/api/all_categories";
    String value = await storage.read(key: "token");
    Map<String, String> headers = {'x-access-token': value};
    final response = await http.get(url + loginUrl, headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    return Categories.fromJson(json.decode(response.body));
  }

  Future<AnnouncementResponce> create(AnnouncementCreate requestModel) async {
    String loginUrl = "/api/create_annotation";
    String value = await storage.read(key: "token");
    Map<String, String> headers = {
      'content-type': 'multipart/form-data',
      'x-access-token': value
    };
    var request = http.MultipartRequest('POST', Uri.parse(url + loginUrl));
    request.headers.addAll(headers);
    request.fields['request'] = json.encode(requestModel).toString();
    if (requestModel.filePath != null) {
      final file =
          await http.MultipartFile.fromPath('files', requestModel.filePath);
      request.files.add(file);
    } else {
      // File f = await getImageFileFromAssets("images/default_avatar.jpg");
      // final file = await http.MultipartFile.fromPath('photo', f.path);
      // request.files.add(file);
      request.files.add(null);
    }

    final response = await request.send();
    // String sfd = response.stream.transform(utf8.decoder).first.toString();
    // String jsonString;
    // response.stream.transform(utf8.decoder).listen((value) {
    //   jsonString = value;
    // });
    // var czcd = json.decode(jsonString);
    return AnnouncementResponce.fromJson(response.statusCode);
    // return PersonalAreaResponseModel.fromJson(response.);
  }
}
