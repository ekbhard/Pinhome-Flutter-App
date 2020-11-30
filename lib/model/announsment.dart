// To parse this JSON data, do
//
//     final announcement = announcementFromJson(jsonString);

import 'dart:convert';

Announcement announcementFromJson(String str) =>
    Announcement.fromJson(json.decode(str));

String announcementToJson(Announcement data) => json.encode(data.toJson());

class Announcement {
  Announcement({
    this.description,
    this.user,
    this.recentlyViewed,
    this.saled,
    this.free,
    this.created,
    this.want,
    this.name,
    this.category,
    this.address,
    this.id,
    this.city,
    this.images,
    this.announcement,
    this.deleted,
  });

  String description;
  int user;
  List<dynamic> recentlyViewed;
  bool saled;
  bool free;
  DateTime created;
  List<Want> want;
  String name;
  int category;
  String address;
  int id;
  String city;
  List<AnnImage> images;
  int announcement;
  bool deleted;

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        description: json["description"],
        user: json["user"],
        recentlyViewed:
            List<dynamic>.from(json["recently_viewed"].map((x) => x)),
        saled: json["saled"],
        created: DateTime.parse(json["created"]),
        want: List<Want>.from(json["want"].map((x) => Want.fromJson(x))),
        free:
            List<Want>.from(json["want"].map((x) => Want.fromJson(x))).length ==
                0,
        name: json["name"],
        category: json["category"],
        address: json["address"],
        id: json["id"],
        city: json["city"],
        images: List<AnnImage>.from(
            json["images"].map((x) => AnnImage.fromJson(x))),
        announcement: json["announcement"],
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "user": user,
        "recently_viewed": List<dynamic>.from(recentlyViewed.map((x) => x)),
        "saled": saled,
        "created": created.toIso8601String(),
        "want": List<dynamic>.from(want.map((x) => x.toJson())),
        "name": name,
        "category": category,
        "address": address,
        "id": id,
        "city": city,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "announcement": announcement,
        "deleted": deleted,
      };
}

class AnnImage {
  AnnImage({
    this.created,
    this.imagesAnnoun,
    this.id,
    this.announcement,
    this.imagePath,
  });

  DateTime created;
  int imagesAnnoun;
  int id;
  int announcement;
  String imagePath;

  factory AnnImage.fromJson(Map<String, dynamic> json) => AnnImage(
        created: DateTime.parse(json["created"]),
        imagesAnnoun: json["images_announ"],
        id: json["id"],
        announcement: json["announcement"],
        imagePath: "https://backend-pin-home-server.site" + json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "created":
            "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
        "images_announ": imagesAnnoun,
        "id": id,
        "announcement": announcement,
        "image_path": imagePath,
      };
}

class Want {
  Want({
    this.strWant,
    this.wantCat,
    this.created,
    this.id,
    this.want,
  });

  String strWant;
  WantCat wantCat;
  DateTime created;
  int id;
  int want;

  factory Want.fromJson(Map<String, dynamic> json) => Want(
        strWant: json["str_want"],
        wantCat: WantCat.fromJson(json["want_cat"]),
        created: DateTime.parse(json["created"]),
        id: json["id"],
        want: json["want"],
      );

  Map<String, dynamic> toJson() => {
        "str_want": strWant,
        "want_cat": wantCat.toJson(),
        "created": created.toIso8601String(),
        "id": id,
        "want": want,
      };
}

class WantCat {
  WantCat({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory WantCat.fromJson(Map<String, dynamic> json) => WantCat(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
