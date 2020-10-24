import 'dart:convert';

import 'package:flutter_app_pinhome/model/personal_area_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/login_model.dart';

class PersonalAreaService {
  final storage = new FlutterSecureStorage();

  String url = "https://pin-home.herokuapp.com";

  Future<LoginResponseModel> create(
      PersonalAreaRequestModel requestModel) async {
    String loginUrl = "/personal_area/";
    String value = await storage.read(key: "token");
    Map<String, String> headers = {
      'content-type': 'multipart/form-data',
      'Cookie': value
    };
    String requestBodqwy = requestModel.toJson().toString();
    var requestBody = requestModel.toJson();
    var request = http.MultipartRequest('POST', Uri.parse(url + loginUrl));
    request.headers.addAll(headers);
    request.fields['request'] = requestBody.toString();
    request.files
        .add(await http.MultipartFile.fromPath('picture', requestModel.file));
    var response = await request.send();
    String sfd = response.stream.transform(utf8.decoder).first.toString();
    // return PersonalAreaResponseModel.fromJson(response.);
    // if (response.statusCode == 200 || response.statusCode == 400) {
    //
    // }
  }
}
