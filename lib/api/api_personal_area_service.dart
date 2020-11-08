import 'dart:async';
import 'dart:convert';

import 'package:flutter_app_pinhome/model/personal_area_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PersonalAreaService {
  final storage = new FlutterSecureStorage();

  // String url = "http://s7b68957b.fastvps-server.com/";
  // String url = "https://pin-home.herokuapp.com/";
  String url = "https://backend-pin-home-server.site";

  Future<PersonalAreaResponseModel> create(
      PersonalAreaRequestModel requestModel) async {
    String loginUrl = "/personal_area/";
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
          await http.MultipartFile.fromPath('photo', requestModel.filePath);
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
    return PersonalAreaResponseModel.fromJson(response.statusCode);
    // return PersonalAreaResponseModel.fromJson(response.);
  }

  // Future<File> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load('$path');
  //
  //   String sfs = await getApplicationDocumentsDirectory().then((value) => value.toString());
  //   final file = File('${(await getApplicationDocumentsDirectory()).path}/$path');
  //   await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //
  //   return file;
  // }

  Future<PersonalAreaRequestModel> get() async {
    String loginUrl = "/personal_area/";
    String value = await storage.read(key: "token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'x-access-token': value
    };
    final response = await http.get(url + loginUrl, headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    Map valueMap = json.decode(response.body)["currently_user"];
    return PersonalAreaRequestModel.fromJson(
        json.decode(response.body)["currently_user"],json.decode(response.body)["photo"]);
  }

  Future<String> getUserAvatar() async {
    String loginUrl = "/personal_area/image";
    String value = await storage.read(key: "token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'x-access-token': value
    };
    final response = await http.get(url + loginUrl, headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception(response.body);
    }
    String url1 = json.decode(response.body)["photo"]["image_path"];
    return url + url1;
  }
}
