// To parse this JSON data, do
//
//     final announcement = announcementFromJson(jsonString);

import 'dart:convert';

// Announcement announcementFromJson(String str) => Announcement.fromJson(json.decode(str));
//
// String announcementToJson(Announcement data) => json.encode(data.toJson());

class Announcement {
  Announcement({
    this.announcement,
  });

  List<AnnouncementElement> announcement;

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
    announcement: List<AnnouncementElement>.from(json["announcement"].map((x) => AnnouncementElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "announcement": List<dynamic>.from(announcement.map((x) => x.toJson())),
  };
}

class AnnouncementElement {
  AnnouncementElement({
    this.description,
    this.images,
    this.city,
    this.announcement,
    this.deleted,
    this.id,
    this.address,
    this.saled,
    this.recentlyViewed,
    this.name,
    this.created,
    this.user,
    this.category,
    this.want,
  });

  String description;
  List<Image> images;
  dynamic city;
  int announcement;
  bool deleted;
  int id;
  dynamic address;
  bool saled;
  List<dynamic> recentlyViewed;
  String name;
  DateTime created;
  int user;
  int category;
  List<dynamic> want;

  factory AnnouncementElement.fromJson(Map<String, dynamic> json) => AnnouncementElement(
    description: json["description"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    city: json["city"],
    announcement: json["announcement"],
    deleted: json["deleted"],
    id: json["id"],
    address: json["address"],
    saled: json["saled"],
    recentlyViewed: List<dynamic>.from(json["recently_viewed"].map((x) => x)),
    name: json["name"],
    created: DateTime.parse(json["created"]),
    user: json["user"],
    category: json["category"],
    want: List<dynamic>.from(json["want"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "city": city,
    "announcement": announcement,
    "deleted": deleted,
    "id": id,
    "address": address,
    "saled": saled,
    "recently_viewed": List<dynamic>.from(recentlyViewed.map((x) => x)),
    "name": name,
    "created": created.toIso8601String(),
    "user": user,
    "category": category,
    "want": List<dynamic>.from(want.map((x) => x)),
  };
}

class Image {
  Image({
    this.announcement,
    this.imagePath,
    this.id,
    this.imagesAnnoun,
    this.created,
  });

  int announcement;
  String imagePath;
  int id;
  int imagesAnnoun;
  DateTime created;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    announcement: json["announcement"],
    imagePath: json["image_path"],
    id: json["id"],
    imagesAnnoun: json["images_announ"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "announcement": announcement,
    "image_path": imagePath,
    "id": id,
    "images_announ": imagesAnnoun,
    "created": "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
  };
}
