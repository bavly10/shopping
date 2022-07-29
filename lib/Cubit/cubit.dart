import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/ProCustomer.dart';
import 'package:shopping/model/categoryModel.dart';
import 'package:shopping/model/splash.dart';
import 'package:shopping/modules/Customer/login/main.dart';
import 'package:shopping/modules/cart/cart.dart';
import 'package:shopping/modules/mainScreen/screen/HomeScreen.dart';
import 'package:shopping/modules/test.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/network.dart';
import 'package:shopping/shared/shared_prefernces.dart';

import '../model/shippingcompanies.dart';


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
     HomeScreen(),
    test(),
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


  ///////////////Get Shipping////////////
  ShippingModel? shippingModel;
  Future<void> getShippingData() async {
    emit(GettingShippingDataLoadingState());
    Map<String, dynamic> header = {
      "auth-token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2thc2g1dGFrLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE2NTc3MzYxNjksImV4cCI6MTY1ODM0MDk2OSwibmJmIjoxNjU3NzM2MTY5LCJqdGkiOiJVRDZuZkFIN3VWVVdyTWtNIiwic3ViIjoiNCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.ryNTe54vJLTFJlk2JF1bAizNMo6XGPaAWkk_vZdlqpw"
    };
    DioHelper.getData(url: ship, option: header).then((value) {
      shippingModel = ShippingModel.fromJson(value.data);
      print(shippingModel.toString());
      print(value.data);
      emit(GettingShippingDataSueccesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GettingShippingDataErrorState());
    });
  }
//////////////////////////splash///////////
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

  //////////////////////////
  CategoryModel? categoryModel;
  Future<void> getCategoriesData() async {
    emit(LoadingCat());
    DioHelper.getData(url: category).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      print("done categoryModel ${categoryModel!.status}");
      emit(DoneCat());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorCat());
    });
  }

  /////////////
  int? selected;
  void getselected(int x) {
    selected = x;
    emit(ChangeSelcect());
  }

  //////////////////////////////////
  ProsCustomerModel? prosCustomerModel;
  void getCustomerData(catId) {
    emit(LoadingProCustomerState());
    Map<String, dynamic> data = {"category_id": catId};
    DioHelper.postData(url: getCustomer, data: data).then((value) {
      prosCustomerModel = ProsCustomerModel.fromJson(value.data);
      if(prosCustomerModel!.data!.isEmpty){
        emit(emptyProCustomerState());
      }else{
        print("done prosCustomer ${prosCustomerModel!.status}");
        emit(DoneProCustomerState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorProCustomerState());
    });
  }
  String? customerToken;
  int? customerId;
  void getMyShared() {
    customerToken = CashHelper.getData("customerToken");
    customerId = CashHelper.getData("customerId");
  }

}
