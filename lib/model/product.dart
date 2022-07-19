// To parse this JSON data, do
//
//     final products = productsFromMap(jsonString);

import 'dart:convert';

Products productsFromMap(String str) => Products.fromMap(json.decode(str));

String productsToMap(Products data) => json.encode(data.toMap());

class Products {
  Products({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  Data? data;

  factory Products.fromMap(Map<String, dynamic> json) => Products(
        status: json["status"],
        msg: json["msg"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "msg": msg,
        "data": data!.toMap(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<ProductItem>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<ProductItem>.from(
            json["data"].map((x) => ProductItem.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class ProductItem {
  ProductItem({
    this.id,
    this.userId,
    this.titleAr,
    this.titleEn,
    this.categoryId,
    this.price,
    this.many,
    this.descAr,
    this.descEn,
    this.s,
    this.m,
    this.l,
    this.xl,
    this.the2Xl,
    this.the3Xl,
    this.the4Xl,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  int? id;
  String? userId;
  String? titleAr;
  String? titleEn;
  String? categoryId;
  String? price;
  String? many;
  String? descAr;
  String? descEn;
  String? s;
  String? m;
  String? l;
  String? xl;
  String? the2Xl;
  String? the3Xl;
  dynamic the4Xl;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Images>? images;

  factory ProductItem.fromMap(Map<String, dynamic> json) => ProductItem(
        id: json["id"],
        userId: json["user_id"],
        titleAr: json["title_ar"],
        titleEn: json["title_en"],
        categoryId: json["category_id"],
        price: json["price"],
        many: json["many"],
        descAr: json["desc_ar"],
        descEn: json["desc_en"],
        s: json["s"],
        m: json["m"],
        l: json["l"],
        xl: json["xl"],
        the2Xl: json["2xl"],
        the3Xl: json["3xl"],
        the4Xl: json["4xl"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        images: json["images"] == null
            ? null
            : List<Images>.from(json["images"].map((x) => Images.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "title_ar": titleAr,
        "title_en": titleEn,
        "category_id": categoryId,
        "price": price,
        "many": many,
        "desc_ar": descAr,
        "desc_en": descEn,
        "s": s,
        "m": m,
        "l": l,
        "xl": xl,
        "2xl": the2Xl,
        "3xl": the3Xl,
        "4xl": the4Xl,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toMap())),
      };
}

class Images {
  Images({
    this.id,
    this.logo,
  });

  int? id;
  String? logo;

  factory Images.fromMap(Map<String, dynamic> json) => Images(
        id: json["id"],
        logo: json["logo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "logo": logo,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromMap(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
// To parse this JSON data, do
//
//     final showProducts = showProductsFromMap(jsonString);



