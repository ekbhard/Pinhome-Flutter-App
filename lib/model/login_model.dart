class LoginResponseModel {
  final String token;
  final String error;
  final bool have;

  LoginResponseModel({this.token, this.error, this.have});

  factory LoginResponseModel.fromJson(
      Map<String, String> headers, bool have, Map<String, dynamic> body) {
    return LoginResponseModel(
        token: headers["set-cookie"] != null ? headers["set-cookie"] : "",
        error: body["error"] != null ? body["error"] : "",
        have: have);
  }
}

class LoginRequestModel {
  String username;
  String password;

  LoginRequestModel({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username.trim(),
      'password': password.trim(),
    };

    return map;
  }
}
