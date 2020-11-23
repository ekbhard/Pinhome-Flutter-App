// To parse this JSON data, do
//
//     final reasonClose = reasonCloseFromJson(jsonString);

import 'dart:convert';

List<ReasonClose> reasonCloseFromJson(String str) => List<ReasonClose>.from(
    json.decode(str).map((x) => ReasonClose.fromJson(x)));

String reasonCloseToJson(List<ReasonClose> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReasonClose {
  ReasonClose({
    this.id,
    this.name,
    this.reasonClosed,
  });

  int id;
  String name;
  List<dynamic> reasonClosed;

  List<ReasonClose> reasonCloseFromJson(String str) => List<ReasonClose>.from(
      json.decode(str).map((x) => ReasonClose.fromJson(x)));

  factory ReasonClose.fromJson(Map<String, dynamic> json) => ReasonClose(
        id: json["id"],
        name: json["name"],
        reasonClosed: List<dynamic>.from(json["reason_closed"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "reason_closed": List<dynamic>.from(reasonClosed.map((x) => x)),
      };
}
