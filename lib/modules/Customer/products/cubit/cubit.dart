import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/model/categoryModel.dart';
import 'package:shopping/modules/Customer/products/cubit/states.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/network.dart';

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

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      emit(TakeImage_State());
      print("3dma noob");
    } else {
      print("3dma zft");
    }
  }

// ignore: non_constant_identifier_names
  Future create( { int? userid, String? tittleAr, String? tittleEn,  int? categoryId, price,many, String? descAr, String? descEn,  int? s, int? m,  int? l, int? xl,  int? twoXl,  int? threexl,  int? fourxl, img}) async {
    Map<String, dynamic> header = {
      "auth-token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2thc2g1dGFrLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE2NTc2NDE5NzksImV4cCI6MTY1NzY0NTU3OSwibmJmIjoxNjU3NjQxOTc5LCJqdGkiOiJ2QjFJVFNpa29CU09EQ3huIiwic3ViIjoiNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.WGmF1cFFDVxCAM8mmxK7BpbUnbKOYCeCpdqRski8Szk",
    };
    FormData formData = FormData.fromMap({
      "user_id": userid,
      "title_ar": tittleAr,
      "title_en": tittleEn,
      "category_id": cat_id,
      "price": price,
      "many": many,
      "desc_ar": descAr??"",
      "desc_en": descEn??"",
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
  bool s = false;
  bool m = false;
  bool l = false;
  bool xl = false;
  bool two_xll = false;
  bool three_xll = false;
  bool four_xll = false;


  void changeSChecked(bool v) {
    s = !s;
    s = v;
    emit(ChangeCheckedState());
  }

  void changeThreeXlChecked(bool v) {
    three_xll = !three_xll;
    three_xll = v;

    emit(ChangeCheckedsState());
  }

  void change4XlChecked(bool v) {
    four_xll = !four_xll;
    four_xll = v;

    emit(ChangeCheckedssState());
  }

  void changelChecked(bool v) {
    l = !l;
    l = v;

    emit(ChangeCheckedSssstate());
  }

  void changexlChecked(bool v) {
    xl = !xl;
    xl = v;

    emit(ChangeCheckedSsxtate());
  }

  void changetwoXlChecked(bool v) {
    two_xll = !two_xll;
    two_xll = v;

    emit(ChangeCheckedSswtate());
  }

  void changetwoMChecked(bool v) {
    m = !m;
    m = v;
    print(m);

    emit(ChangeCheckedSsztate());
  }


}