import 'dart:convert';

import 'package:flutter_app_pinhome/model/close_model.dart';
import 'package:flutter_app_pinhome/model/reason_close.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CloseService {
  final storage = new FlutterSecureStorage();
  String url = "https://backend-pin-home-server.site";

  Future<int> delete(Close requestModel, int id) async {
    await storage.deleteAll();
    String deleteUrl = "/api/close_announcement/" + id.toString();
    Map<String, String> headers = {'content-type': 'application/json'};
    try {
      final response = await http.post(url + deleteUrl,
          headers: headers, body: json.encode(requestModel));
      return response.statusCode;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<ReasonClose>> get() async {
    String getUrl = "/api/reason_close";
    String value = await storage.read(key: "token");
    Map<String, String> headers = {'x-access-token': value};
    final response = await http.get(url + getUrl, headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    List<ReasonClose> ssd = List<ReasonClose>.from(
        json.decode(response.body).map((x) => ReasonClose.fromJson(x)));
    return List<ReasonClose>.from(
        json.decode(response.body).map((x) => ReasonClose.fromJson(x)));
  }
}
