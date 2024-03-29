import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myshoop/Cubit/cubit.dart';
import 'package:myshoop/model/CustomerModel.dart';
import 'package:myshoop/model/cart.dart';
import 'package:myshoop/model/categoryModel.dart';
import 'package:myshoop/model/owner_earn_model.dart';
import 'package:myshoop/model/product.dart';
import 'package:myshoop/model/product_info.dart';
import 'package:myshoop/model/show_product_model.dart';
import 'package:myshoop/modules/Customer/login/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/products/cubit/states.dart';
import 'package:myshoop/shared/compononet/myToast.dart';
import 'package:myshoop/shared/diohelper/dioHelpoer.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/network.dart';
import 'package:myshoop/shared/shared_prefernces.dart';

import '../../../../model/privacy_policy.dart';
import '../../../../model/show_product_model.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductShop_InitalState());

  static ProductCubit get(context) => BlocProvider.of(context);

  String? catSelect;
  int? cat_id;
  ProductShow? showProd;
  bool accept = false;

  void changeSelectCategory(val) {
    catSelect = val.title;
    cat_id = val.id;
    print(cat_id);
    emit(Changestate());
  }

  List<XFile> imageFileList = [];
  final ImagePicker imagePicker = ImagePicker();

  void selectImages(context) async {
    // imageFileList = [];
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      if (selectedImages.length <= 6 && imageFileList.length <= 6) {
        imageFileList.addAll(selectedImages);
        emit(TakeImage_State());
        print("takeImage");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              mytranslate(context, "exceed"),
            ),
            padding: const EdgeInsets.all(8),
            duration: const Duration(milliseconds: 3000),
          ),
        );
      }
    } else {
      print("3dma zft");
    }
  }

// ignore: non_constant_identifier_names
  Future create(
      {context,
      int? userid,
      String? tittleAr,
      String? tittleEn,
      int? categoryId,
      price,
      many,
      String? descAr,
      String? descEn,
      img}) async {
    ShopCubit.get(context).getMyShared();
    Map<String, dynamic> header = {
      "auth-token": ShopCubit.get(context).customerToken,
    };
    FormData formData = FormData.fromMap({
      "user_id": userid,
      "title_ar": tittleAr,
      "title_en": tittleEn,
      "category_id": cat_id,
      "price": price,
      "many": many,
      "desc_ar": descAr ?? "",
      "desc_en": descEn ?? "",
      "s": s,
      "m": m,
      "l": l,
      "xl": xl,
      "two_xl": two_xll,
      "three_xl": three_xll,
      "four_xl": four_xll,
      "image[]": img
    });
    DioHelper.postData1(url: createProduct, data: formData, option: header)
        .then((value) {
      debugPrint(value.data.toString());
      print("done");
      emit(CreatingSueccs());
    }).catchError((error) {
      emit(CreatingError());
      print(error.toString());
    });
  }

  ////////////////////////update/////////////////
  Future update({
    context,
    int? id,
    String? tittleAr,
    String? tittleEn,
    price,
    many,
    String? descAr,
    String? descEn,
    img,
  }) async {
    ShopCubit.get(context).getMyShared();
    Map<String, dynamic> header = {
      "auth-token": ShopCubit.get(context).customerToken,
    };
    FormData formData = FormData.fromMap({
      "id": id,
      "category_id": cat_id,
      "title_ar": tittleAr,
      "title_en": tittleEn,
      "price": price,
      "many": many,
      "desc_ar": descAr ?? "",
      "desc_en": descEn ?? "",
      "s": s,
      "m": m,
      "l": l,
      "xl": xl,
      "two_xl": two_xll,
      "three_xl": three_xll,
      "four_xl": four_xll,
      "image[]": img
    });
    await DioHelper.postData1(url: updateProduct, data: formData, option: header)
        .then((value) {debugPrint(value.data.toString());
          if(value.data['status']==true) {
            emit(UpdatingSueccs());
          }
            else{
            emit(UpdatingProductError(value.data['msg']));
          }

    }).catchError((error) {
      debugPrint(error.toString());
      emit(UpdatingError(error));
    });
  }

  int s = 0;
  int m = 0;
  int l = 0;
  int xl = 0;
  int two_xll = 0;
  int three_xll = 0;
  int four_xll = 0;
  bool sm = false;
  bool me = false;
  bool la = false;
  bool xla = false;
  bool two_xlla = false;
  bool three_xlla = false;
  bool four_xlla = false;

  void changeSChecked(bool v) {
    sm = !sm;
    sm = v;
    if (v == true) {
      s = 1;
    } else {
      s = 0;
    }
    emit(ChangeCheckedState());
  }

  void changeThreeXlChecked(bool v) {
    three_xlla = !three_xlla;
    three_xlla = v;
    if (v == true) {
      three_xll = 1;
    } else {
      three_xll = 0;
    }

    emit(ChangeCheckedsState());
  }

  void change4XlChecked(bool v) {
    four_xlla = !four_xlla;
    if (v == true) {
      four_xll = 1;
    } else {
      four_xll = 0;
    }
    emit(ChangeCheckedssState());
  }

  void changelChecked(bool v) {
    la = !la;
    la = v;
    if (v == true) {
      l = 1;
    } else {
      l = 0;
    }

    emit(ChangeCheckedSssstate());
  }

  void changexlChecked(bool v) {
    xla = !xla;
    xla = v;
    if (v == true) {
      xl = 1;
    } else {
      xl = 0;
    }

    emit(ChangeCheckedSstate());
  }

  void changetwoXlChecked(bool v) {
    two_xlla = !two_xlla;
    two_xlla = v;
    if (v == true) {
      two_xll = 1;
    } else {
      two_xll = 0;
    }

    emit(ChangeCheckedSswtate());
  }

  void changetwoMChecked(bool v) {
    me = !me;
    me = v;
    if (v == true) {
      m = 1;
    } else {
      m = 0;
    }

    emit(ChangeCheckedSsztate());
  }

  Products? pro;

  /////////////////////////Get Product in main Screen/////////////////////
  List<ProductItemMainCustomer> listProduct = [];
  List<ProductItemMainCustomer> listProducts = [];
  List<ProductItemMainCustomer> search = [];
  List<dynamic> searchCustomer(String quary) {
    search = [];
    var searching = listProducts
        .where((element) =>
            element.titleAr!.toLowerCase().contains(quary.toLowerCase()))
        .toList();
    search = searching;
    // print(search[0].title);
    emit(SearchingProduct());
    return search;
  }

  DataProductMainCustomer? datak;
  int limit = 1;
  int pagnationDataLimit() {
    print(limit);
    return limit += 1;
  }

  Future getProducts(context, numberPage) async {
    listProduct = [];
    ShopCubit.get(context).getMyShared();
    emit(GettingProductDataLoading());
    Map<String, dynamic> data = {
      "user_id": ShopCubit.get(context).customerId,
      "page": numberPage
    };
    Map<String, dynamic> header = {
      "auth-token": ShopCubit.get(context).customerToken,
    };
    await DioHelper.postData(url: getProduct, data: data, option: header)
        .then((value) {
      final res = value.data['data'];
      datak = DataProductMainCustomer.fromMap(res);
      print(datak!.currentPage);
      final mylist = res['data'] as List;
      if (mylist.isEmpty) {
        emit(GettingProductDataNull());
      } else {
        for (var value in mylist) {
          final pro = listProduct.indexWhere((element) => element.id == value["id"].toString(),
          );
          if (pro >= 0) {
            listProduct[pro] = ProductItemMainCustomer(
              id: value["id"],
              titleAr: value["title_ar"],
              price: value["price"],
              many: value["many"],
              images: (value["images"] as List<dynamic>)
                  .map((e) => ImagesPro(
                        id: e["id".toString()],
                        logo: e["logo"].toString(),
                      ))
                  .toList(),
            );
            listProducts[pro] = ProductItemMainCustomer(
              id: value["id"],
              titleAr: value["title_ar"],
              price: value["price"],
              many: value["many"],
              images: (value["images"] as List<dynamic>)
                  .map((e) => ImagesPro(
                        id: e["id".toString()],
                        logo: e["logo"].toString(),
                      ))
                  .toList(),
            );
          } else {
            listProduct.add(ProductItemMainCustomer(
              id: value["id"],
              titleAr: value["title_ar"],
              price: value["price"],
              many: value["many"],
              images: (value["images"] as List<dynamic>)
                  .map((e) => ImagesPro(
                        id: e["id".toString()],
                        logo: e["logo"].toString(),
                      ))
                  .toList(),
            ));
            listProducts.add(ProductItemMainCustomer(
              id: value["id"],
              titleAr: value["title_ar"],
              price: value["price"],
              many: value["many"],
              images: (value["images"] as List<dynamic>)
                  .map((e) => ImagesPro(
                        id: e["id".toString()],
                        logo: e["logo"].toString(),
                      ))
                  .toList(),
            ));
          }
        }
        emit(GettingProductData());
      }
    }).catchError((error) {
      print(error.toString());
      emit(GettingProductDataError());
    });
  }

///////////Show Product In update Screen///////////////////////
  Future showPro(id, context) async {
    emit(loadingProduct());
    Map<String, dynamic> header = {
      "auth-token": ShopCubit.get(context).customerToken
    };
    FormData formData = FormData.fromMap({"id": id});
    await DioHelper.postData1(url: showProduct, data: formData, option: header)
        .then((value) {
      showProd = ProductShow.fromMap(value.data);
      emit(ShowingProduct());
    }).catchError((error) {
      print(error.toString());
      emit(failProduct());
    });
  }

  ProductInfo? proInf;
  List<String> sizes = [];
  String? selectSize = "M";
  Future productInfo(id, context) async {
    emit(loadingProduct());
    FormData formData = FormData.fromMap({"product_id": id});
    await DioHelper.postData1(
      url: getOneProduct,
      data: formData,
    ).then((value) {
      proInf = ProductInfo.fromMap(value.data);
      print(proInf!.data!.id);
      sizes = [];
      if (proInf!.data!.s == "1") {
        sizes.add("s");
      }
      if (proInf!.data!.m == "1") {
        sizes.add("M");
      }
      if (proInf!.data!.l == "1") {
        sizes.add("L");
      }
      if (proInf!.data!.xl == "1") {
        sizes.add("XL");
      }
      if (proInf!.data!.the2Xl == "1") {
        sizes.add("2XL");
      }
      if (proInf!.data!.the3Xl == "1") {
        sizes.add("3XL");
      }
      if (proInf!.data!.the4Xl == "1") {
        sizes.add("4XL");
      }
      emit(ShowingProduct());
    }).catchError((error) {
      print(error.toString());
      emit(failProduct());
    });
  }

  void changeSize(val) {
    selectSize = val;
    emit(ChooseSize());
  }

////////////////////////// clear image/////////////////////
  Future deleteImage({id, context}) async {
    ShopCubit.get(context).getMyShared();
    Map<String, dynamic> header = {
      "auth-token": ShopCubit.get(context).customerToken,
    };
    FormData formData = FormData.fromMap({"id": id});
    DioHelper.postData1(url: deleteProductImage, data: formData, option: header)
        .then((value) {
      debugPrint(value.data.toString());
      emit(DeletingImageProduct());
      print("done");
      emit(ShowingProduct());
    }).catchError((error) {
      print(error.toString());
    });
  }

/////////////////////Delete Product//////////////////////
  deletePro({id, context}) async {
    ShopCubit.get(context).getMyShared();
    FormData formData = FormData.fromMap({"id": id});
    Map<String, dynamic> header = {
      "auth-token": LoginCubit.get(context).loginModel!.data!.token,
    };
    DioHelper.postData1(
      option: header,
      url: deleteProduct,
      data: formData,
    ).then((value) {
      debugPrint(value.data.toString());
      emit(DeletingImageProduct());
      print("done");
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future getLogout(context) async {
    ShopCubit.get(context).getMyShared();
    Map<String, dynamic> map = {
      "auth-token": ShopCubit.get(context).customerToken
    };
    await DioHelper.postData(url: logout, data: map).then((value) {
      CashHelper.removeData("customerToken");
      CashHelper.removeData("customerId");
      emit(GettingLogoutDone());
    }).catchError((error) {
      emit(GettingLogoutError());
    });
  }

  ////////////////////cart///////////

  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }


  OwnerEarn? ownerEarn;
  Future <void> getEarn() async {
    emit(ShopEarnLoadingState());
   await DioHelper.getData(url: "/earn-num").then((value) {
      ownerEarn = OwnerEarn.fromMap(value.data);
      emit(ShopEarnSuessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorEarnState());
    });
  }

  double get totalamount {
    var total = 0.0;
    _items.forEach((key, Cartitem) {
      total += Cartitem.price * Cartitem.quantity;
    });
    return total;
  }

  int get itemcount {
    return _items.length;
  }

  void additem(
      {required String proid,
      required String imgurl,
      required String title,
      required double price,
      required String size,
      required int qua,
      String? rate}) {
    if (_items.containsKey(proid)) {
      _items.update(
          proid,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity + 1,
              price: value.price,
              size: value.size,
              imgurl: value.imgurl,
              rate: value.rate));
    }
    else {
      _items.putIfAbsent(
          proid,
          () => CartItem(
              size: size,
              id: proid,
              title: title,
              quantity: qua,
              price: price,
              imgurl: imgurl,
              rate: rate));
    }
    emit(ShopAddItems());
  }

  void removeCart(){
    return _items.clear();
  }
  void removeitem(String proid) {
    _items.remove(proid);
    emit(ShopRemoveItems());
  }

  void removesingleitem(String proid) {
    if (!_items.containsKey(proid)) {
      return;
    }
    if (_items[proid]!.quantity > 1) {
      _items.update(
          proid,
          (value) => CartItem(
              size: value.size,
              id: value.id,
              title: value.title,
              quantity: value.quantity - 1,
              price: value.price,
              imgurl: value.imgurl));
    } else {
      myToast(message: "Not Allowed");
    }
    emit(ShopRemoveItem());
  }

  void clear() {
    _items = {};
  }

  int itemCount = 1;
  void plus() {
    itemCount++;
    emit(ShopChangeplus());
  }

  void minuss() {
    if (itemCount <= 1) {
      itemCount = 1;
    } else {
      itemCount--;
    }
    emit(ShopChangeminus());
  }

  ////////////////create order////////////////////////////
  Future createOrder({productID, many, customerID, size, price}) async {
    emit(InsertOrderLoadingState());
    Map<String, dynamic> data = {
      "product_id": productID,
      "price": price,
      "many": many,
      "size": size,
      "customer_id": customerID
    };
    await DioHelper.postData(
      url: orderNew,
      data: data,
    ).then((value) {
      if (value.data['status'] == true) {
        print("done Order");
        emit(InsertOrderSucessState());
      } else {
        print(value.data.toString());
        emit(InsertOrderErrorState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(InsertOrderErrorState());
    });
  }

  ////////////Show Customer profile/////////
  File? file;
  CustomerModel? prosCustomerModel;
  Future showCustomerData(id, context) async {
    emit(LoadingShowCustomer());
    Map<String, dynamic> header = {
      "auth-token": ShopCubit.get(context).customerToken
    };
    Map<String, dynamic> data = {
      "id": id,
    };
    await DioHelper.postData(url: showUser, data: data, option: header)
        .then((value) {
      //  print(value.data);
      prosCustomerModel = CustomerModel.fromJson(value.data);
      file = File(prosCustomerModel!.data!.logo!);
      print(prosCustomerModel!.data!.id!);
      emit(ShowingCustomerData());
    }).catchError((error) {
      print(error.toString());
      emit(FailShowCustomerData());
    });
  }

  changeChecked(bool v) {
    accept = !accept;
    emit(ChooseAcceptState());
  }

  PrivacyPolicy? privacySalla;
  getPrivacyPolicy() {
    emit(SallaPrivacyPolicyLoadingState());
    DioHelper.getData(url: sallaPrivacy).then((value) {
      privacySalla = PrivacyPolicy.fromMap(value.data);
      emit(SallaPrivacyPolicySueccState());
      print("Get Privacy.. ${privacySalla!.status}");
    }).catchError((onError) {
      print(onError.toString());
      emit(SallaPrivacyPolicyErrorState());
    });
  }


  ////Categories Update & Create Product/////
  CategoryModel? categoryModel;
  Future<void> getCategoriesData() async {
    emit(LoadingCat());
    Map<String, dynamic> data = {"type": ""};
    DioHelper.postData(url: category, data: data).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      print("done categoryModel ${categoryModel!.status}");
      emit(DoneCat());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorCat());
    });
  }
}
