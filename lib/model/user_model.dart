import 'dart:convert';

User userModelFromMap(String str) => User.fromMap(json.decode(str));

String userModelToMap(User data) => json.encode(data.toMap());

class User {
  User({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  int? data;

  factory User.fromMap(Map<String, dynamic> json) => User(
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
