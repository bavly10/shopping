import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.msg,
    this.data,
    this.errorCode,
  });

  bool? status;
  String? msg;
  UserModel? data;
  int? errorCode;
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    msg: json["msg"],
    errorCode: json["error-code"]== null?null:json["error-code"],
    data:json["data"]==null?null: UserModel.fromJson(json["data"]),

  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data!.toJson(),
  };
}

class UserModel {
  UserModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.address,
    this.longitude,
    this.latitude,
    this.titleAr,
    this.titleEn,
    this.male,
    this.female,
    this.baby,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  int? id;
  String? nameAr;
  String? nameEn;
  String? email;
  DateTime? emailVerifiedAt;
  String? phone;
  String? address;
  String? longitude;
  String? latitude;
  String? titleAr;
  String? titleEn;
  String? male;
  String? female;
  String? baby;
  String? logo;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    nameAr: json["name_ar"],
    nameEn: json["name_en"],
    email: json["email"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    phone: json["phone"],
    address: json["address"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    titleAr: json["title_ar"],
    titleEn: json["title_en"],
    male: json["male"],
    female: json["female"],
    baby: json["baby"],
    logo: json["logo"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_ar": nameAr,
    "name_en": nameEn,
    "email": email,
    "email_verified_at": emailVerifiedAt!.toIso8601String(),
    "phone": phone,
    "address": address,
    "longitude": longitude,
    "latitude": latitude,
    "title_ar": titleAr,
    "title_en": titleEn,
    "male": male,
    "female": female,
    "baby": baby,
    "logo": logo,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "token": token,
  };
}
