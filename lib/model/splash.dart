import 'dart:convert';
SplashModel splashFromJson(String str) => SplashModel.fromJson(json.decode(str));
String splashToJson(SplashModel data) => json.encode(data.toJson());

class SplashModel {
  SplashModel({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  Data? data;

  factory SplashModel.fromJson(Map<String, dynamic> json) => SplashModel(
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
    this.splash,
    this.male,
    this.female,
    this.baby,
  });

  String? splash;
  String? male;
  String? female;
  String? baby;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    splash: json["splash"],
    male: json["male"],
    female: json["female"],
    baby: json["baby"],
  );

  Map<String, dynamic> toJson() => {
    "splash": splash,
    "male": male,
    "female": female,
    "baby": baby,
  };
}
