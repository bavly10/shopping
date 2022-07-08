import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  List<CatItem>? data;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    status: json["status"],
    msg: json["msg"],
    data: List<CatItem>.from(json["data"].map((x) => CatItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CatItem {
  CatItem({
    this.id,
    this.title,
    this.logo,
  });

  int? id;
  String? title;
  String? logo;

  factory CatItem.fromJson(Map<String, dynamic> json) => CatItem(
    id: json["id"],
    title: json["title"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "logo": logo,
  };
}
