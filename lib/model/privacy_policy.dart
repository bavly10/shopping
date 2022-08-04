// To parse this JSON data, do
//
//     final privacyPolicy = privacyPolicyFromMap(jsonString);

import 'dart:convert';

PrivacyPolicy privacyPolicyFromMap(String str) =>
    PrivacyPolicy.fromMap(json.decode(str));

String privacyPolicyToMap(PrivacyPolicy data) => json.encode(data.toMap());

class PrivacyPolicy {
  PrivacyPolicy({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  String? data;

  factory PrivacyPolicy.fromMap(Map<String, dynamic> json) => PrivacyPolicy(
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
