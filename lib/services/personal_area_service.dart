import 'package:flutter_app_pinhome/services/utills.dart';
import 'package:flutter_session/flutter_session.dart';

import 'auth_service.dart';

class PersonalAreaService {
  Future<dynamic> create(String username, String password) async {
    // dynamic token = await FlutterSession().get("token");
    dynamic token = AuthService.getToken();
    Map<String, String> body = {'username': username, 'password': password};
    try {
      Future<Map<Object, Object>> res = Utills.postRequestWithHeaders(
          'personal_area/personal_area', body, {'Cookie': token});
      return res;
    } finally {
      // done you can do something here
    }
  }
}
