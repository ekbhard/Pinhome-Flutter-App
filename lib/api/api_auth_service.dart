import 'dart:convert';

import 'package:flutter_app_pinhome/model/registration_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/login_model.dart';

class AuthService {
  final storage = new FlutterSecureStorage();

  String url = "https://backend-pin-home-server.site";

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    await storage.deleteAll();
    String loginUrl = "/authorization/sign_in";
    Map<String, String> headers = {'content-type': 'application/json'};
    try {
      final response = await http.post(url + loginUrl,
          headers: headers, body: json.encode(requestModel));
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> requestBody = json.decode(response.body);
        bool have = requestBody["have_personal_area"];
        String token = requestBody["token"];
        // String token = response.headers["set-cookie"].replaceAll(RegExp('[\";]'), "").split(" ")[0];
        storage.write(key: "token", value: token);
        return LoginResponseModel.fromJson(
            response.headers, have, json.decode(response.body));
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<int> logout() async {
    String loginUrl = "/authorization/logout";
    String value = await storage.read(key: "token");
    Map<String, String> headers = {'x-access-token': value};
    final response = await http.get(url + loginUrl, headers: headers);
    if (response.statusCode == 200) {
      storage.delete(key: "token");
    }
    return response.statusCode;
  }

  Future<RegistrationResponseModel> registration(
      RegistrationRequestModel requestModel) async {
    String loginUrl = "/authorization/sign_up";
    Map<String, String> headers = {'content-type': 'application/json'};
    try {
      final response = await http.post(url + loginUrl,
          headers: headers, body: json.encode(requestModel));
      String sfd = response.headers.toString();
      if (response.statusCode == 201) {
        Map<String, dynamic> sdf = json.decode(response.body);
        return RegistrationResponseModel.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
