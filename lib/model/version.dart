import 'dart:convert';

Version versionFromJson(String str) => Version.fromJson(json.decode(str));

String versionToJson(Version data) => json.encode(data.toJson());

class Version {
  Version({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  Data data;

  factory Version.fromJson(Map<String, dynamic> json) => Version(
    status: json["status"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.ver,
    required this.link,
  });

  String ver;
  String link;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    ver: json["ver"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "ver": ver,
    "link": link,
  };
}
