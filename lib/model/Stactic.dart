// To parse this JSON data, do
//
//     final statistics = statisticsFromJson(jsonString);

import 'dart:convert';

Statistics statisticsFromJson(String str) => Statistics.fromJson(json.decode(str));

String statisticsToJson(Statistics data) => json.encode(data.toJson());

class Statistics {
  Statistics({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  DataStatics? data;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    status: json["status"],
    msg: json["msg"],
    data: DataStatics.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data!.toJson(),
  };
}

class DataStatics {
  DataStatics({
    this.totalEarn,
    this.years,
    this.months,
  });

  int? totalEarn;
  Map<String, Month>? years;
  Map<String, Month>? months;

  factory DataStatics.fromJson(Map<String, dynamic> json) => DataStatics(
    totalEarn: json["total-earn"],
    years: Map.from(json["years"]).map((k, v) => MapEntry<String, Month>(k, Month.fromJson(v))),
    months: Map.from(json["months"]).map((k, v) => MapEntry<String, Month>(k, Month.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "total-earn": totalEarn,
    "years": Map.from(years!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "months": Map.from(months!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Month {
  Month({
    this.height,
    this.customer,
    this.earn,
  });

  int? height;
  int? customer;
  int? earn;

  factory Month.fromJson(Map<String, dynamic> json) => Month(
    height: json["height"],
    customer: json["customer"],
    earn: json["earn"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "customer": customer,
    "earn": earn,
  };
}
