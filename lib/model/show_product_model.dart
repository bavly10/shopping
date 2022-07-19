import 'dart:convert';

ProductShow showProductFromMap(String str) =>
    ProductShow.fromMap(json.decode(str));

String showProductToMap(ProductShow data) => json.encode(data.toMap());

class ProductShow {
  ProductShow({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  Data1? data;

  factory ProductShow.fromMap(Map<String, dynamic> json) => ProductShow(
        status: json["status"],
        msg: json["msg"],
        data: Data1.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "msg": msg,
        "data": data!.toMap(),
      };
}

class Data1 {
  Data1({
    this.productData,
    this.images,
  });

  ProductData? productData;
  List<Imagess>? images;

  factory Data1.fromMap(Map<String, dynamic> json) => Data1(
        productData: json["product_data"] == null
            ? null
            : ProductData.fromMap(json["product_data"]),
        images: json["images"] == null
            ? null
            : List<Imagess>.from(json["images"].map((x) => Imagess.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "product_data": productData == null ? null : productData!.toMap(),
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toMap())),
      };
}

class Imagess {
  Imagess({
    this.id,
    this.logo,
  });

  int? id;
  String? logo;

  factory Imagess.fromMap(Map<String, dynamic> json) => Imagess(
        id: json["id"],
        logo: json["logo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "logo": logo,
      };
}

class ProductData {
  ProductData({
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

  factory ProductData.fromMap(Map<String, dynamic> json) => ProductData(
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
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
