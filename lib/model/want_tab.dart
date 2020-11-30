// To parse this JSON data, do
//
//     final wantTab = wantTabFromJson(jsonString);

import 'dart:convert';

List<WantTab> wantTabFromJson(String str) => List<WantTab>.from(json.decode(str).map((x) => WantTab.fromJson(x)));

String wantTabToJson(List<WantTab> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WantTab {
  WantTab({
    this.created,
    this.want,
    this.wantCat,
    this.strWant,
    this.id,
  });

  DateTime created;
  int want;
  WantCat wantCat;
  String strWant;
  int id;

  factory WantTab.fromJson(Map<String, dynamic> json) => WantTab(
    created: DateTime.parse(json["created"]),
    want: json["want"],
    wantCat: WantCat.fromJson(json["want_cat"]),
    strWant: json["str_want"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "created": created.toIso8601String(),
    "want": want,
    "want_cat": wantCat.toJson(),
    "str_want": strWant,
    "id": id,
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
