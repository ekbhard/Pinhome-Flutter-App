class AnnouncementCreate {
  AnnouncementCreate({
    this.name,
    this.description,
    this.category,
    this.city,
    this.strWant,
    this.want,
    this.filePath,
  });

  String name;
  String description;
  int category;
  String city;
  String strWant;
  List<Want> want;
  String filePath;

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "category": category,
        "city": city,
        "str_want": strWant,
        "want": List<dynamic>.from(want.map((x) => x.toJson())),
      };
}

class Want {
  Want({
    this.category,
  });

  int category;

  factory Want.fromJson(Map<String, dynamic> json) => Want(
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
  };
}

class AnnouncementResponce {
  AnnouncementResponce({
    this.status,
  });

  int status;

  factory AnnouncementResponce.fromJson(int status) => AnnouncementResponce(
        status: status,
      );

  Map<String, dynamic> toJson() => {
        "result": status,
      };
}
