// To parse this JSON data, do
//
//     final prosCustomerModel = prosCustomerModelFromJson(jsonString);

import 'dart:convert';

ProsCustomerModel prosCustomerModelFromJson(String str) =>
    ProsCustomerModel.fromJson(json.decode(str));

String prosCustomerModelToJson(ProsCustomerModel data) =>
    json.encode(data.toJson());

class ProsCustomerModel {
  ProsCustomerModel({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  List<ProCustomer>? data;

  factory ProsCustomerModel.fromJson(Map<String, dynamic> json) =>
      ProsCustomerModel(
        status: json["status"],
        msg: json["msg"],
        data: List<ProCustomer>.from(
            json["data"].map((x) => ProCustomer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProCustomer {
  ProCustomer(
      {this.id,
      required this.name,
      this.phone,
      this.address,
      this.longitude,
      this.latitude,
      this.male,
      this.female,
      this.baby,
      this.logo,
      this.rate});

  final String name;
  String? phone;
  String? address;
  String? longitude;
  String? latitude;
  String? male;
  String? female;
  String? baby;
  String? logo;
  int? id;
  String? rate;

  factory ProCustomer.fromJson(Map<String, dynamic> json) => ProCustomer(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      address: json["address"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      male: json["male"],
      female: json["female"],
      baby: json["baby"],
      logo: json["logo"],
      rate: json["rate"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "male": male,
        "female": female,
        "baby": baby,
        "logo": logo,
        "rate": rate
      };
}
