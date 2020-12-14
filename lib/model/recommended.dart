// To parse this JSON data, do
//
//     final recommended = recommendedFromJson(jsonString);

import 'dart:convert';

Recommended recommendedFromJson(String str) =>
    Recommended.fromJson(json.decode(str));

String recommendedToJson(Recommended data) => json.encode(data.toJson());

class Recommended {
  Recommended({
    this.result,
  });

  List<Result> result;

  factory Recommended.fromJson(Map<String, dynamic> json) => Recommended(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.user,
    this.name,
    this.recentlyViewed,
    this.address,
    this.announcement,
    this.images,
    this.city,
    this.description,
    this.created,
    this.category,
    this.delete,
    this.noExchange,
    this.saled,
    this.want,
    this.reason,
    this.id,
  });

  int user;
  String name;
  List<dynamic> recentlyViewed;
  String address;
  int announcement;
  List<Image> images;
  String city;
  String description;
  DateTime created;
  int category;
  bool delete;
  bool noExchange;
  bool saled;
  List<dynamic> want;
  dynamic reason;
  int id;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        user: json["user"],
        name: json["name"],
        recentlyViewed:
            List<dynamic>.from(json["recently_viewed"].map((x) => x)),
        address: json["address"],
        announcement: json["announcement"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        city: json["city"],
        description: json["description"],
        created: DateTime.parse(json["created"]),
        category: json["category"],
        delete: json["delete"],
        noExchange: json["no_exchange"],
        saled: json["saled"],
        want: List<dynamic>.from(json["want"].map((x) => x)),
        reason: json["reason"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "recently_viewed": List<dynamic>.from(recentlyViewed.map((x) => x)),
        "address": address,
        "announcement": announcement,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "city": city,
        "description": description,
        "created": created.toIso8601String(),
        "category": category,
        "delete": delete,
        "no_exchange": noExchange,
        "saled": saled,
        "want": List<dynamic>.from(want.map((x) => x)),
        "reason": reason,
        "id": id,
      };
}

class Image {
  Image({
    this.announcement,
    this.imagesAnnoun,
    this.imagePath,
    this.created,
    this.id,
  });

  int announcement;
  int imagesAnnoun;
  String imagePath;
  DateTime created;
  int id;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        announcement: json["announcement"],
        imagesAnnoun: json["images_announ"],
        imagePath: "https://backend-pin-home-server.site" + json["image_path"],
        created: DateTime.parse(json["created"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "announcement": announcement,
        "images_announ": imagesAnnoun,
        "image_path": imagePath,
        "created":
            "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
        "id": id,
      };
}
