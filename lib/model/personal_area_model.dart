class PersonalAreaResponseModel {
  final String message;

  PersonalAreaResponseModel({this.message});

  factory PersonalAreaResponseModel.fromJson(Map<String, String> body) {
    return PersonalAreaResponseModel(
        message: body["message"] != null ? body["error"] : "");
  }
}

class PersonalAreaRequestModel {
  String surname;
  String name;
  String patronymic;
  String phoneNumber;
  String email;
  String geolocation;
  String file;

  PersonalAreaRequestModel(
      {this.surname,
      this.name,
      this.patronymic,
      this.phoneNumber,
      this.email,
      this.geolocation,
      this.file});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'surname': surname.trim(),
      'name': name.trim(),
      'patronymic': patronymic.trim(),
      'phoneNumber': phoneNumber.trim(),
      'email': email.trim(),
      'geolocation': geolocation.trim(),
    };

    return map;
  }
}
