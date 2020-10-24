import 'dart:convert';
import 'dart:io';

class Utills {
  static Future<Map<Object, Object>> postRequest(
      String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient
        .postUrl(Uri.parse('http://pin-home.herokuapp.com' + url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    int status = response.statusCode;
    String cookies =
        response.cookies.toString().replaceAll('[', '').split(";")[0];
    String reply = await response.transform(utf8.decoder).join();
    Map<Object, Object> map = {
      'status': status,
      'response_body': reply,
      'cookies': cookies
    };
    httpClient.close();
    return map;
  }

  static Future<Map<Object, Object>> postRequestWithHeaders(
      String url, Map jsonMap, Map<String, String> headers) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient
        .postUrl(Uri.parse('http://pin-home.herokuapp.com' + url));
    request.headers.set('content-type', 'application/json');
    if (headers.isNotEmpty) {
      headers.forEach((key, value) {
        request.headers.set(key, value);
      });
    }
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    int status = response.statusCode;
    String cookies =
        response.cookies.toString().replaceAll('[', '').split(";")[0];
    String reply = await response.transform(utf8.decoder).join();
    Map<Object, Object> map = {
      'status': status,
      'response_body': reply,
      'cookies': cookies
    };
    httpClient.close();
    return map;
  }
}
