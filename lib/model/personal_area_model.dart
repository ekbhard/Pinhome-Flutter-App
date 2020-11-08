class PersonalAreaResponseModel {
  final int status;

  PersonalAreaResponseModel({this.status});

  factory PersonalAreaResponseModel.fromJson( int status) {
    return PersonalAreaResponseModel(
        status: status);
  }
}

class PersonalAreaRequestModel {
  String surname;
  String name;
  String patronymic;
  String phoneNumber;
  String email;
  String geolocation;
  String filePath;
  String imgUrl;

  PersonalAreaRequestModel(
      {this.surname,
      this.name,
      this.imgUrl,
      this.patronymic,
      this.phoneNumber,
      this.email,
      this.geolocation,
      this.filePath});

  factory PersonalAreaRequestModel.fromJson(Map<String, dynamic> body,Map<String, dynamic> photo) {
    return PersonalAreaRequestModel(
      surname: body["surname"],
      name: body["name"],
      patronymic: body["patronymic"],
      phoneNumber: body["phone_number"],
      email: body["email"],
      geolocation: body["geolocation"],
      imgUrl: "https://backend-pin-home-server.site" + photo["image_path"] ,
    );
  }

  Map<String, String> toJson() {
    Map<String, String> map = {
      'surname': surname.trim(),
      'name': name.trim(),
      'patronymic': patronymic.trim(),
      'phone_number': phoneNumber.trim(),
      'email': email.trim(),
      'geolocation': geolocation.trim(),
    };

    return map;
  }
}
