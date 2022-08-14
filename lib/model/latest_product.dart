// To parse this JSON data, do
//
//     final latestProduct = latestProductFromMap(jsonString);

import 'dart:convert';

LatestProduct latestProductFromMap(String str) =>
    LatestProduct.fromMap(json.decode(str));

String latestProductToMap(LatestProduct data) => json.encode(data.toMap());

class LatestProduct {
  LatestProduct({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  List<LatestProductItem>? data;

  factory LatestProduct.fromMap(Map<String, dynamic> json) => LatestProduct(
        status: json["status"],
        msg: json["msg"],
        data: List<LatestProductItem>.from(
            json["data"].map((x) => LatestProductItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class LatestProductItem {
  LatestProductItem({
    this.id,
    this.userId,
    this.title,
    this.price,
    this.many,
    this.desc,
    this.s,
    this.m,
    this.l,
    this.xl,
    this.the2Xl,
    this.the3Xl,
    this.the4Xl,
    this.image,
  });

  int? id;
  String? userId;
  String? title;
  String? price;
  String? many;
  String? desc;
  String? s;
  String? m;
  String? l;
  String? xl;
  String? the2Xl;
  String? the3Xl;
  String? the4Xl;
  String? image;

  factory LatestProductItem.fromMap(Map<String, dynamic> json) =>
      LatestProductItem(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        price: json["price"],
        many: json["many"],
        desc: json["desc"],
        s: json["s"],
        m: json["m"],
        l: json["l"],
        xl: json["xl"],
        the2Xl: json["2xl"],
        the3Xl: json["3xl"],
        the4Xl: json["4xl"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "price": price,
        "many": many,
        "desc": desc,
        "s": s,
        "m": m,
        "l": l,
        "xl": xl,
        "2xl": the2Xl,
        "3xl": the3Xl,
        "4xl": the4Xl,
        "image": image,
      };
}
