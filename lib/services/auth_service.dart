import 'package:flutter_app_pinhome/services/utills.dart';
import 'package:flutter_session/flutter_session.dart';

class AuthService {
  final baseUrl = 'https://pin-home.herokuapp.com';

  // ignore: non_constant_identifier_names
  static final SESSION = FlutterSession();

  Future<dynamic> register(String username, String password) async {
    Map<String, String> body = {'username': username, 'password': password};
    try {
      Future<Map<Object, Object>> res =
          Utills.postRequest('/authorization/sign_up', body);
      return res;
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> login(String username, String password) async {
    Map<String, String> body = {'username': username, 'password': password};
    try {
      Future<Map<Object, Object>> res =
          Utills.postRequest('/authorization/sign_in', body);
      return res;
    } finally {
      // you can do somethig here
    }
  }

  static setToken(String token) async {
    _AuthData data = _AuthData(token);
    await SESSION.set('cookie', data.cookie);
  }

  static Future<Map<String, dynamic>> getToken() async {
    return await SESSION.get('cookie');
  }

  static removeToken() async {
    await SESSION.prefs.clear();
  }
}

class _AuthData {
  String cookie;

  _AuthData(this.cookie);

  // toJson
  // required by Session lib
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['cookie'] = cookie;
    return data;
  }
}
