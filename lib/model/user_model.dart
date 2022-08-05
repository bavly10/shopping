import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  int? data;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "msg": msg,
        "data": data,
      };
}
