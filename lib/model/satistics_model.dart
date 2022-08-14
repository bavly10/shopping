// To parse this JSON data, do
//
//     final satistics = satisticsFromMap(jsonString);

import 'dart:convert';

Satistics satisticsFromMap(String str) => Satistics.fromMap(json.decode(str));

String satisticsToMap(Satistics data) => json.encode(data.toMap());

class Satistics {
  Satistics({
    this.status,
    this.msg,
    this.data,
  });

  bool? status;
  String? msg;
  SatisticsItem? data;

  factory Satistics.fromMap(Map<String, dynamic> json) => Satistics(
        status: json["status"],
        msg: json["msg"],
        data: SatisticsItem.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "msg": msg,
        "data": data!.toMap(),
      };
}

class SatisticsItem {
  SatisticsItem({
    this.totalEarn,
    this.years,
    this.months,
  });

  int? totalEarn;
  Map<String, Month>? years;
  Map<String, Month>? months;

  factory SatisticsItem.fromMap(Map<String, dynamic> json) => SatisticsItem(
        totalEarn: json["total-earn"],
        years: Map.from(json["years"])
            .map((k, v) => MapEntry<String, Month>(k, Month.fromMap(v))),
        months: Map.from(json["months"])
            .map((k, v) => MapEntry<String, Month>(k, Month.fromMap(v))),
      );

  Map<String, dynamic> toMap() => {
        "total-earn": totalEarn,
        "years": years == null
            ? null
            : Map.from(years!)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toMap())),
        "months": months == null
            ? null
            : Map.from(months!)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toMap())),
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

  factory Month.fromMap(Map<String, dynamic> json) => Month(
        height: json["height"],
        customer: json["customer"],
        earn: json["earn"],
      );

  Map<String, dynamic> toMap() => {
        "height": height,
        "customer": customer,
        "earn": earn,
      };
}
