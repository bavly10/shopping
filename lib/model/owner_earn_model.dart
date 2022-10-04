import 'dart:convert';

OwnerEarn ownerEarnFromMap(String str) => OwnerEarn.fromMap(json.decode(str));

String ownerEarnToMap(OwnerEarn data) => json.encode(data.toMap());

class OwnerEarn {
  OwnerEarn({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  OwnerItem? data;

  factory OwnerEarn.fromMap(Map<String, dynamic> json) => OwnerEarn(
        status: json["status"],
        msg: json["msg"],
        data: OwnerItem.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "msg": msg,
        "data": data!.toMap(),
      };
}

class OwnerItem {
  OwnerItem({
    this.ownerEarn,
    this.ownerEarnActive,
    this.shopingEarn,
    this.shopingEarnActive,
  });

  String? ownerEarn;
  String? ownerEarnActive;
  String? shopingEarn;
  String? shopingEarnActive;

  factory OwnerItem.fromMap(Map<String, dynamic> json) => OwnerItem(
        ownerEarn: json["owner_earn"],
        ownerEarnActive: json["owner_earn_active"],
        shopingEarn: json["shoping_earn"],
        shopingEarnActive: json["shoping_earn_active"],
      );

  Map<String, dynamic> toMap() => {
        "owner_earn": ownerEarn,
        "owner_earn_active": ownerEarnActive,
        "shoping_earn": shopingEarn,
        "shoping_earn_active": shopingEarnActive,
      };
}
