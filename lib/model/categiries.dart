import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    this.category,
  });

  List<Category> category;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.parentId,
    this.id,
    this.name,
  });

  int parentId;
  int id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "parent_id": parentId == null ? null : parentId,
    "id": id.toString(),
    "name": name,
  };
}
