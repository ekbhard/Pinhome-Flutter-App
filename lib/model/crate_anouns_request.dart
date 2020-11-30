class AnnouncementCreate {
  AnnouncementCreate({
    this.name,
    this.description,
    this.category,
    this.want,
    this.city,
    this.address,
    this.filePath,
  });

  String name;
  String description;
  String category;
  List<Want> want;
  String city;
  String address;
  String filePath;

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        // "category": category,
        "category": 1,
        "want": want != null
            ? List<dynamic>.from(want.map((x) => x.toJson()))
            : List.empty(),
        "city": city,
        "address": "address",
      };
}

class Want {
  int categoryId;
  String strWant;

  Map<String, dynamic> toJson() => {
        "category": categoryId,
        "str_want": strWant,
      };

  Want(int categoryId, String strWant) {
    this.categoryId = categoryId;
    this.strWant = strWant;
  }
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
