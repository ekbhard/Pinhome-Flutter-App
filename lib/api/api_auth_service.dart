import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/login_model.dart';

class AuthService {
  final storage = new FlutterSecureStorage();

  String url = "https://pin-home.herokuapp.com";

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String loginUrl = "/authorization/sign_in";
    Map<String, String> headers = {'content-type': 'application/json'};
    try {
      final response = await http.post(url + loginUrl,
          headers: headers, body: json.encode(requestModel));
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> sdf = json.decode(response.body);
        bool have = sdf["have_personal_area"];
        String token = response.headers["set-cookie"];
        storage.write(key: "token", value: token);
        return LoginResponseModel.fromJson(
            response.headers, have, json.decode(response.body));
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
