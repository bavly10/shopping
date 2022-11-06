import 'dart:convert';

OrdersCutomer ordersCutomerFromJson(String str) => OrdersCutomer.fromJson(json.decode(str));

String ordersCutomerToJson(OrdersCutomer data) => json.encode(data.toJson());

class OrdersCutomer {
  OrdersCutomer({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  Data? data;

  factory OrdersCutomer.fromJson(Map<String, dynamic> json) => OrdersCutomer(
    status: json["status"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data!.toJson(),
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
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<DataOrder>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: List<DataOrder>.from(json["data"].map((x) => DataOrder.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class DataOrder {
  DataOrder({
    this.id,
    this.many,
    this.size,
    this.price,
    this.time,
   this.readOrNow,
    this.productOrder,
    this.userInfo,
    this.total,
  });

  int? id;
  String? many;
  String? size;
  String? price;
   String? readOrNow;
   String? time;
  ProductOrder? productOrder;
  UserInfoOrder? userInfo;
  int? total;

  factory DataOrder.fromJson(Map<String, dynamic> json) => DataOrder(
    id: json["id"],
    many: json["many"],
    size: json["size"],
    time: json["created_at"],
    price: json["price"],
    readOrNow: json["read"],
    productOrder: ProductOrder.fromJson(json["product"]),
    userInfo: UserInfoOrder.fromJson(json["user_info"]),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "many": many,
    "size": size,
    "price": price,
    "product": productOrder!.toJson(),
    "user_info": userInfo!.toJson(),
    "total": total,
  };
}

class ProductOrder {
  ProductOrder({
    this.id,
    this.title,
    this.price,
    this.desc,
    this.image,
  });

  int? id;
  String? title;
  String? price;
  String? desc;
  String?image;

  factory ProductOrder.fromJson(Map<String, dynamic> json) => ProductOrder(
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

class UserInfoOrder {
  UserInfoOrder({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;

  factory UserInfoOrder.fromJson(Map<String, dynamic> json) => UserInfoOrder(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
  };
}
