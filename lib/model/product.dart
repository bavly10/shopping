class Product {
  bool? status;
  String? msg;
  Data? data;

  Product({this.status, this.msg, this.data});

  Product.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  ProductData? productData;
  List<Images>? images;

  Data({this.productData, this.images});

  Data.fromJson(Map<String, dynamic> json) {
    productData = json['product_data'] != null
        ? ProductData.fromJson(json['product_data'])
        : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (productData != null) {
      data['product_data'] = productData!.toJson();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  int? id;
  String? userId;
  String? titleAr;
  String? titleEn;
  String? categoryId;
  String? price;
  String? many;
  String? descAr;
  String? descEn;
  String? s;
  String? m;
  String? l;
  String? xl;
  String? s2xl;
  String? s3xl;
  String? s4xl;
  String? createdAt;
  String? updatedAt;

  ProductData(
      {this.id,
      this.userId,
      this.titleAr,
      this.titleEn,
      this.categoryId,
      this.price,
      this.many,
      this.descAr,
      this.descEn,
      this.s,
      this.m,
      this.l,
      this.xl,
      this.s2xl,
      this.s3xl,
      this.s4xl,
      this.createdAt,
      this.updatedAt});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
    categoryId = json['category_id'];
    price = json['price'];
    many = json['many'];
    descAr = json['desc_ar'];
    descEn = json['desc_en'];
    s = json['s'];
    m = json['m'];
    l = json['l'];
    xl = json['xl'];
    s2xl = json['2xl'];
    s3xl = json['3xl'];
    s4xl = json['4xl'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['title_ar'] = titleAr;
    data['title_en'] = titleEn;
    data['category_id'] = categoryId;
    data['price'] = price;
    data['many'] = many;
    data['desc_ar'] = descAr;
    data['desc_en'] = descEn;
    data['s'] = s;
    data['m'] = m;
    data['l'] = l;
    data['xl'] = xl;
    data['2xl'] = s2xl;
    data['3xl'] = s3xl;
    data['4xl'] = s4xl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Images {
  int? id;
  String? logo;

  Images({this.id, this.logo});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['logo'] = logo;
    return data;
  }
}
