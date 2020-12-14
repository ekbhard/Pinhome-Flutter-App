// To parse this JSON data, do
//
//     final announcementAll = announcementAllFromJson(jsonString);

import 'dart:convert';

AnnouncementAll announcementAllFromJson(String str) => AnnouncementAll.fromJson(json.decode(str));

String announcementAllToJson(AnnouncementAll data) => json.encode(data.toJson());

class AnnouncementAll {
  AnnouncementAll({
    this.announcement,
  });

  List<Announcement> announcement;

  factory AnnouncementAll.fromJson(Map<String, dynamic> json) => AnnouncementAll(
    announcement: List<Announcement>.from(json["announcement"].map((x) => Announcement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "announcement": List<dynamic>.from(announcement.map((x) => x.toJson())),
  };
}

class Announcement {
  Announcement({
    this.want,
    this.created,
    this.category,
    this.reason,
    this.description,
    this.announcement,
    this.name,
    this.user,
    this.noExchange,
    this.images,
    this.address,
    this.city,
    this.delete,
    this.recentlyViewed,
    this.id,
    this.saled,
    this.strWant,
  });

  List<Want> want;
  DateTime created;
  int category;
  Reason reason;
  String description;
  int announcement;
  String name;
  int user;
  bool noExchange;
  List<Image> images;
  String address;
  String city;
  bool delete;
  List<int> recentlyViewed;
  int id;
  bool saled;
  String strWant;

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
    want: List<Want>.from(json["want"].map((x) => Want.fromJson(x))),
    created: DateTime.parse(json["created"]),
    category: json["category"],
    reason: json["reason"] == null ? null : Reason.fromJson(json["reason"]),
    description: json["description"],
    announcement: json["announcement"],
    name: json["name"],
    user: json["user"],
    noExchange: json["no_exchange"] == null ? null : json["no_exchange"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    address: json["address"],
    city: json["city"],
    delete: json["delete"],
    recentlyViewed: List<int>.from(json["recently_viewed"].map((x) => x)),
    id: json["id"],
    saled: json["saled"],
    strWant: json["str_want"],
  );

  Map<String, dynamic> toJson() => {
    "want": List<dynamic>.from(want.map((x) => x.toJson())),
    "created": created.toIso8601String(),
    "category": category,
    "reason": reason == null ? null : reason.toJson(),
    "description": description,
    "announcement": announcement,
    "name": name,
    "user": user,
    "no_exchange": noExchange == null ? null : noExchange,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "address": address,
    "city": city,
    "delete": delete,
    "recently_viewed": List<dynamic>.from(recentlyViewed.map((x) => x)),
    "id": id,
    "saled": saled,
    "str_want": strWant,
  };
}

class Image {
  Image({
    this.created,
    this.imagesAnnoun,
    this.imagePath,
    this.id,
    this.announcement,
  });

  DateTime created;
  int imagesAnnoun;
  String imagePath;
  int id;
  int announcement;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    created: DateTime.parse(json["created"]),
    imagesAnnoun: json["images_announ"],
    imagePath: json["image_path"],
    id: json["id"],
    announcement: json["announcement"],
  );

  Map<String, dynamic> toJson() => {
    "created": "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
    "images_announ": imagesAnnoun,
    "image_path": imagePath,
    "id": id,
    "announcement": announcement,
  };
}

class Reason {
  Reason({
    this.created,
    this.reasonClose,
    this.closed,
    this.typeClose,
    this.id,
  });

  DateTime created;
  ReasonClose reasonClose;
  List<int> closed;
  ReasonClose typeClose;
  int id;

  factory Reason.fromJson(Map<String, dynamic> json) => Reason(
    created: DateTime.parse(json["created"]),
    reasonClose: ReasonClose.fromJson(json["reason_close"]),
    closed: List<int>.from(json["closed"].map((x) => x)),
    typeClose: ReasonClose.fromJson(json["type_close"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "created": created.toIso8601String(),
    "reason_close": reasonClose.toJson(),
    "closed": List<dynamic>.from(closed.map((x) => x)),
    "type_close": typeClose.toJson(),
    "id": id,
  };
}

class ReasonClose {
  ReasonClose({
    this.name,
    this.id,
  });

  String name;
  int id;

  factory ReasonClose.fromJson(Map<String, dynamic> json) => ReasonClose(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}

class Want {
  Want({
    this.want,
    this.created,
    this.wantCat,
    this.id,
  });

  int want;
  DateTime created;
  ReasonClose wantCat;
  int id;

  factory Want.fromJson(Map<String, dynamic> json) => Want(
    want: json["want"],
    created: DateTime.parse(json["created"]),
    wantCat: ReasonClose.fromJson(json["want_cat"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "want": want,
    "created": created.toIso8601String(),
    "want_cat": wantCat.toJson(),
    "id": id,
  };
}
