class ShippingModel {
  bool? status;
  String? msg;
  List<Data>? data;

  ShippingModel({this.status, this.msg, this.data});

  ShippingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? desc;
  String? logo;
  String? link;
  String? phone;

  Data({this.id, this.title, this.desc, this.logo, this.link, this.phone});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    logo = json['logo'];
    link = json['link'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['logo'] = logo;
    data['link'] = link;
    data['phone'] = phone;
    return data;
  }
}
