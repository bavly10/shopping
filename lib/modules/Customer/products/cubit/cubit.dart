import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/model/categoryModel.dart';
import 'package:shopping/model/product.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/network.dart';

import '../../../../shared/verification_dialog.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductShop_InitalState());

  static ProductCubit get(context) => BlocProvider.of(context);

  String? catSelect;
  int? cat_id;

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

  Product? showProd;
  Future showPro(id) async {
    emit(loadingProduct());
    Map<String, dynamic> header = {
      "auth-token":
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2thc2g1dGFrLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE2NTc3MTExMjAsImV4cCI6MTY1ODMxNTkyMCwibmJmIjoxNjU3NzExMTIwLCJqdGkiOiJoZDdPOWxRVm4zdGg4aEJqIiwic3ViIjoiNyIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.ybeuLPcOA5KEbqQD52KthLquRwh2o1T9ujWUVqeujL0"
    };
    FormData formData = FormData.fromMap({"id": id});
    DioHelper.postData1(url: showProduct, data: formData, option: header)
        .then((value) {
      showProd = Product.fromJson(value.data);
      print(showProd!.data!.productData!.id);
      emit(ShowingProduct());
    }).catchError((error) {
      print(error.toString());
      emit(failProduct());
    });
  }

  Future deleteImage({id}) async {
    Map<String, dynamic> header = {
      "auth-token":
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2thc2g1dGFrLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE2NTc3MTExMjAsImV4cCI6MTY1ODMxNTkyMCwibmJmIjoxNjU3NzExMTIwLCJqdGkiOiJoZDdPOWxRVm4zdGg4aEJqIiwic3ViIjoiNyIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.ybeuLPcOA5KEbqQD52KthLquRwh2o1T9ujWUVqeujL0"
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

  deletePro({id}) async {
    Map<String, dynamic> header = {
      "auth-token":
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2thc2g1dGFrLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE2NTc3MTExMjAsImV4cCI6MTY1ODMxNTkyMCwibmJmIjoxNjU3NzExMTIwLCJqdGkiOiJoZDdPOWxRVm4zdGg4aEJqIiwic3ViIjoiNyIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.ybeuLPcOA5KEbqQD52KthLquRwh2o1T9ujWUVqeujL0"
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

// ignore: non_constant_identifier_names
  Future create(
      {int? userid,
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
      "auth-token":
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2thc2g1dGFrLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE2NTc3MTExMjAsImV4cCI6MTY1ODMxNTkyMCwibmJmIjoxNjU3NzExMTIwLCJqdGkiOiJoZDdPOWxRVm4zdGg4aEJqIiwic3ViIjoiNyIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.ybeuLPcOA5KEbqQD52KthLquRwh2o1T9ujWUVqeujL0"
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
  Future update(
      {int? id,
      String? tittleAr,
      String? tittleEn,
      price,
      many,
      String? descAr,
      String? descEn,
      img,
      context}) async {
    Map<String, dynamic> header = {
      "auth-token":
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2thc2g1dGFrLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE2NTc3MTExMjAsImV4cCI6MTY1ODMxNTkyMCwibmJmIjoxNjU3NzExMTIwLCJqdGkiOiJoZDdPOWxRVm4zdGg4aEJqIiwic3ViIjoiNyIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.ybeuLPcOA5KEbqQD52KthLquRwh2o1T9ujWUVqeujL0"
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
      emit(UpdatingSueccs());

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
}
