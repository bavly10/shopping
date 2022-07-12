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

// ignore: non_constant_identifier_names
  Future create( {required int userid, String? tittleAr, String? tittleEn, required int categoryId, required dynamic price, required many, String? descAr, String? descEn, required bool s, required bool m, required bool l, required bool xl, required bool twoXl, required bool threexl, required bool fourxl, img, categoryModel}) async {
    Map<String, dynamic> header = {
      "auth-token":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2thc2g1dGFrLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE2NTc0NzU1MzAsImV4cCI6MTY1NzQ3OTEzMCwibmJmIjoxNjU3NDc1NTMwLCJqdGkiOiI3TkFlNDRmZHRRVlNGNVVLIiwic3ViIjoiNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.SHai9sFdyzkBXlr0CaALdtgUMtEZwDCiQ9lBK4_E2DM"
    };
    FormData formData = FormData.fromMap({
      "user_id": userid,
      "title_ar": tittleAr ?? "",
      "title_en": tittleEn ?? "",
      "category_id": categoryModel,
      "price": price,
      "many": many,
      "desc_ar": descAr ?? "",
      "desc_en": descEn ?? "",
      "s": s,
      "m": m,
      "l": l,
      "xl": xl,
      "two_xl": two_xl,
      "three_xl": three_xl,
      "four_xl": four_xl,
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
  bool two_xl = false;
  bool three_xl = false;
  bool four_xl = false;


  void changeSChecked(bool v) {
    s = !s;
    s = v;
    emit(ChangeCheckedState());
  }

  void changeThreeXlChecked(bool v) {
    three_xl = !three_xl;
    three_xl = v;

    emit(ChangeCheckedsState());
  }

  void change4XlChecked(bool v) {
    four_xl = !four_xl;
    four_xl = v;

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
    two_xl = !two_xl;
    two_xl = v;

    emit(ChangeCheckedSswtate());
  }

  void changetwoMChecked(bool v) {
    m = !m;
    m = v;
    print(m);

    emit(ChangeCheckedSsztate());
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
  String? catSelect;
  int? cat_id;
  void changeSelectCategory(val) {
    catSelect = val.title;
    cat_id = val.id;
    print(cat_id);
    emit(Changestate());
  }

}