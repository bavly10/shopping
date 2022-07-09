import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/categoryModel.dart';
import 'package:shopping/model/splash.dart';
import 'package:shopping/model/CustomerModel.dart';
import 'package:shopping/modules/Customer/login/main.dart';
import 'package:shopping/modules/cart/cart.dart';
import 'package:shopping/modules/mainScreen/screen/HomeScreen.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/network.dart';
import 'package:shopping/shared/shared_prefernces.dart';

import '../modules/mainScreen/screen/products/products.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(Shop_InitalState());
  static ShopCubit get(context) => BlocProvider.of(context);
  // ignore: non_constant_identifier_names
  Locale? locale_cubit;
  String? lang;
  static bool xtranslate = false;
  void changeLang(lang) async {
    Locale currentLocale = await setLocale(lang.lang_Code);
    changLocale(currentLocale);
  }

  changLocale(Locale currentLocale) {
    locale_cubit = currentLocale;
  }

  Future<Locale> locale(String lang) async {
    switch (lang) {
      case "en":
        xtranslate = false;
        locale_cubit = Locale(lang, "US");
        break;
      case "ar":
        xtranslate = true;
        locale_cubit = Locale(lang, "SA");

        break;
      default:
        locale_cubit = const Locale("ar", "SA");
    }
    emit(cons_Change_Language());
    return locale_cubit!;
  }

  Future<Locale> setLocale(String langCode) async {
    await CashHelper.putData("locale", langCode);
    return locale(langCode);
  }

  Future<Locale> getLocale() async {
    lang = CashHelper.getData("locale");
    return locale(lang!);
  }

  int currentindex = 0;
  List<Widget> screen = [
    const HomeScreen(),
    const Products(),
    CartScreen(),
    MainLogin()
  ];

  void changeIndex(int index) {
    currentindex = index;
    emit(ChangeIndexTabs());
  }

  bool changeAppBar = true;
  void changeSearchAppBar() {
    changeAppBar = !changeAppBar;
    emit(ChangeAppBar());
  }

  int detailsIndex = 0;
  void getDetailsIndex(index) {
    detailsIndex = index;
    emit(ChangeIndexBar());
  }

  SplashModel? splashModel;
  Future<void> getSplashData() async {
    emit(LoadingSplash());
    DioHelper.getData(url: splash).then((value) {
      splashModel = SplashModel.fromJson(value.data);
      print("done Splash model ${splashModel!.status}");
      emit(DoneSplash());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorSplash());
    });
  }
  ////////////////////////////////////////////

  Future create() async {
    FormData formData = FormData.fromMap({
      "user_id": 4,
      "title_ar": "x shoe",
      "title_en": "x shoe",
      "category_id": 10,
      "price": 100,
      "many": 111,
      "desc_ar": "jbcxhjvhjxvchjvj",
      "desc_en": "jjkshkjkjjg",
      "s": 1,
      "m": 1,
      "l": 1,
      "xl": 1,
      "two_xl": 1,
      "three_xl": 1,
      "four_xl": 1,
      "image":
      [
        for (var file in imageFileList)
          {
            await MultipartFile.fromFileSync(
              file.path,
            )
          }
      ]
    });

    Map<String, dynamic> header = {
      "auth-token":
"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2thc2g1dGFrLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE2NTczODczNTgsImV4cCI6MTY1NzM5MDk1OCwibmJmIjoxNjU3Mzg3MzU4LCJqdGkiOiJtT0hjQUJndXlQV3JIdGhYIiwic3ViIjoiNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.tQ-Juhi1rxBIHRG_PTxDZGQcoQHJylu8Ew-_IbUZ1Bs"
    };

    DioHelper.postData1(url: createProduct, data: formData, option: header)
        .then((value) {
      debugPrint(value.data.toString());
      print("done");
    }).catchError((error) {
      print(error.toString());
    });
  }

  bool m = false;
  bool l = false;
  bool xl = false;
  bool two_xl = false;
  bool three_xl = false;
  bool four_xl = false;

  bool s = false;

  void changeSChecked(bool v) {
    s = !s;
    s = v;

    emit(ChangeCheckedState());
  }

  void changeThreeXlChecked(bool v) {
    three_xl = !three_xl;
    three_xl = v;

    emit(ChangeCheckedState());
  }

  void change4XlChecked(bool v) {
    four_xl = !four_xl;
    four_xl = v;

    emit(ChangeCheckedState());
  }

  void changelChecked(bool v) {
    l = !l;
    l = v;

    emit(ChangeCheckedState());
  }

  void changexlChecked(bool v) {
    xl = !xl;
    xl = v;

    emit(ChangeCheckedState());
  }

  void changetwoXlChecked(bool v) {
    two_xl = !two_xl;
    two_xl = v;

    emit(ChangeCheckedState());
  }

  void changetwoMChecked(bool v) {
    m = !m;
    m = v;
    print(m);

    emit(ChangeCheckedState());
  }


  List<XFile> imageFileList = [];
  final ImagePicker imagePicker = ImagePicker();

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      emit(TakeImage_State());
      print("3dma noob");
    }else{
      print("3dma zft");
    }
  }
  //////////////////////////
  CategoryModel? categoryModel;
  Future<void> getCategoriesData() async {
    emit(LoadingCat());
    DioHelper.getData(url: category).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      print("done Cat model ${splashModel!.status}");
      emit(DoneCat());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorCat());
    });
  }
  /////////////
  int? selected;
  void getselected(int x){
    selected=x;
    emit(ChangeSelcect());
  }
  //////////////////////////////////
  CustomerModel? customerModel;
  void getCustomerData(catId) {
    emit(LoadingCustomer());
    Map<String,dynamic> data={"category_id":catId};
    DioHelper.postData(url: getCustomer,data:data).then((value) {
      customerModel = CustomerModel.fromJson(value.data);
      print("done Cat model ${splashModel!.status}");
      emit(DoneCustomer());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorCustomer());
    });
  }

}
