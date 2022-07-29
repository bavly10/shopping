// To parse this JSON data, do
//
//     final productInfo = productInfoFromMap(jsonString);

import 'dart:convert';

ProductInfo productInfoFromMap(String str) =>
    ProductInfo.fromMap(json.decode(str));

String productInfoToMap(ProductInfo data) => json.encode(data.toMap());

class ProductInfo {
  ProductInfo({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  ProductInfoItem? data;

  factory ProductInfo.fromMap(Map<String, dynamic> json) => ProductInfo(
        status: json["status"],
        msg: json["msg"],
        data: ProductInfoItem.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "msg": msg,
        "data": ProductInfoItem,
      };
}

class ProductInfoItem {
  ProductInfoItem({
    this.id,
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
    this.images,
  });

  int? id;
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
  dynamic the4Xl;
  List<ImageInfoPro>? images;

  factory ProductInfoItem.fromMap(Map<String, dynamic> json) => ProductInfoItem(
        id: json["id"],
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
        images: List<ImageInfoPro>.from(
            json["images"].map((x) => ImageInfoPro.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
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
        "images": List<dynamic>.from(images!.map((x) => x.toMap())),
      };
}

class ImageInfoPro {
  ImageInfoPro({
    this.id,
    this.logo,
  });

  int? id;
  String? logo;

  factory ImageInfoPro.fromMap(Map<String, dynamic> json) => ImageInfoPro(
        id: json["id"],
        logo: json["logo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "logo": logo,
      };
}
