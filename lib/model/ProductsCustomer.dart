import 'dart:convert';

ProductsCustomerModel productsCustomerFromJson(String str) => ProductsCustomerModel.fromJson(json.decode(str));

String productsCustomerToJson(ProductsCustomerModel data) => json.encode(data.toJson());

class ProductsCustomerModel {
  ProductsCustomerModel({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  List<ProductsItem>? data;

  factory ProductsCustomerModel.fromJson(Map<String, dynamic> json) => ProductsCustomerModel(
    status: json["status"],
    msg: json["msg"],
    data: List<ProductsItem>.from(json["data"].map((x) => ProductsItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ProductsItem {
  ProductsItem({
    this.id,
    this.title,
    this.price,
    this.desc,
    this.image,
  });

  String? id;
  String? title;
  String? price;
  String? desc;
  String? image;

  factory ProductsItem.fromJson(Map<String, dynamic> json) => ProductsItem(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    desc: json["desc"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "desc": desc,
    "image": image,
  };
}
