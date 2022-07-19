import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/model/categoryModel.dart';
import 'package:shopping/model/product.dart';
import 'package:shopping/model/show_product_model.dart';
import 'package:shopping/model/show_product_model.dart';
import 'package:shopping/model/show_product_model.dart';
import 'package:shopping/model/show_product_model.dart';
import 'package:shopping/modules/Customer/login/cubit/cubit.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/network.dart';

import '../../../../model/show_product_model.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductShop_InitalState());

  static ProductCubit get(context) => BlocProvider.of(context);

  String? catSelect;
  int? cat_id;
  ProductShow? showProd;

  void changeSelectCategory(val) {
    catSelect = val.title;
    cat_id = val.id;
    print(cat_id);
    emit(Changestate());
  }

  List<XFile> imageFileList = [];
  final ImagePicker imagePicker = ImagePicker();

  void selectImages(context) async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      if (selectedImages.length <= 6 && imageFileList.length <= 6) {
        imageFileList.addAll(selectedImages);
        emit(TakeImage_State());
        print("3dma noob");
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
      int? s,
      int? m,
      int? l,
      int? xl,
      int? twoXl,
      int? threexl,
      int? fourxl,
      img}) async {
    Map<String, dynamic> header = {
      "auth-token": LoginCubit.get(context).loginModel!.data!.token,
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
      "two_xl": twoXl,
      "three_xl": threexl,
      "four_xl": fourxl,
      "image[]": img
    });
    DioHelper.postData1(url: createProduct, data: formData, option: header)
        .then((value) {
      debugPrint(value.data.toString());
      print("done");
    }).catchError((error) {
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
    Map<String, dynamic> header = {
      "auth-token": LoginCubit.get(context).loginModel!.data!.token,
    };
    FormData formData = FormData.fromMap({
      "id": id,
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
    DioHelper.postData1(url: updateProduct, data: formData, option: header)
        .then((value) {
      print(value.data.toString());
      emit(CreatingSueccs());

      print("done");
    }).catchError((error) {
      print(error.toString());
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

    emit(ChangeCheckedSsxtate());
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
  DataProductMainCustomer? datak;
  Future getProducts(id) async {
    listProduct = [];
    emit(GettingProductDataLoading());
    Map<String, dynamic> data = {"user_id": 4};
    Map<String, dynamic> header = {
      "auth-token":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2thc2g1dGFrLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE2NTc3MzYxNjksImV4cCI6MTY1ODM0MDk2OSwibmJmIjoxNjU3NzM2MTY5LCJqdGkiOiJVRDZuZkFIN3VWVVdyTWtNIiwic3ViIjoiNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.ryNTe54vJLTFJlk2JF1bAizNMo6XGPaAWkk_vZdlqpw"
      // "auth-token": LoginCubit.get(context).loginModel!.data!.token,
    };
    await DioHelper.postData(url: getProduct, data: data, option: header)
        .then((value) {
      final res = value.data['data'];
      datak=DataProductMainCustomer.fromMap(res);
      print(datak!.currentPage);
      final mylist=res['data'];
      for (var value in mylist) {
        final pro = listProduct.indexWhere((element) => element.id == value["id"].toString(),);
        if (pro >= 0) {
          listProduct[pro] = ProductItemMainCustomer(
            id: value["id"],
            titleAr: value["title_ar"],
            price: value["price"],
            many: value["many"],
              images:(value["images"] as List<dynamic>).map((e) => ImagesPro(id: e["id".toString()], logo: e["logo"].toString(),)).toList(),
          );
        } else {
          listProduct.add(ProductItemMainCustomer(
            id: value["id"],
            titleAr: value["title_ar"],
            price: value["price"],
            many: value["many"],
            images:(value["images"] as List<dynamic>).map((e) => ImagesPro(id: e["id".toString()], logo: e["logo"].toString(),)).toList(),
          ));
        }
      }
      emit(GettingProductData());
    }).catchError((error) {
      print(error.toString());
      emit(GettingProductDataError());
    });
  }

///////////Show Product In update Screen///////////////////////
  Future showPro(id, context) async {
    emit(loadingProduct());
    Map<String, dynamic> header = {
     "auth-token": LoginCubit.get(context).loginModel!.data!.token,
    };
    FormData formData = FormData.fromMap({"id": id});
    DioHelper.postData1(url: showProduct, data: formData, option: header)
        .then((value) {
      showProd = ProductShow.fromMap(value.data);
      emit(ShowingProduct());
    }).catchError((error) {
      print(error.toString());
      emit(failProduct());
    });
  }

////////////////////////// clear image/////////////////////
  Future deleteImage({id, context}) async {
    Map<String, dynamic> header = {
      "auth-token": LoginCubit.get(context).loginModel!.data!.token,
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
    Map<String, dynamic> header = {
      "auth-token": LoginCubit.get(context).loginModel!.data!.token,
    };
    FormData formData = FormData.fromMap({"id": id});
    DioHelper.postData1(url: deleteProduct, data: formData, option: header)
        .then((value) {
      debugPrint(value.data.toString());
      emit(DeletingImageProduct());
      print("done");
      emit(ShowingProduct());
    }).catchError((error) {
      print(error.toString());
    });
  }
}
