class RegistrationResponseModel {
  final String error;
  final String message;

  RegistrationResponseModel({this.error, this.message});

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> body) {
    return RegistrationResponseModel(
        error: body["error"] != null ? body["error"] : "",
        message: body["message"] != null ? body["message"] : "");

  }
}

class RegistrationRequestModel {
  String username;
  String password;

  RegistrationRequestModel({
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
