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

import '../model/shippingcompanies.dart';
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


  ///////////////Get Shipping////////////
  ShippingModel? shippingModel;
  Future<void> getShippingData() async {
    emit(GettingShippingDataLoadingState());
    Map<String, dynamic> header = {
      "auth-token":
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2thc2g1dGFrLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE2NTc0ODQ2NzAsImV4cCI6MTY1NzQ4ODI3MCwibmJmIjoxNjU3NDg0NjcwLCJqdGkiOiI2VFRkT0RDamRMcVlzdmtyIiwic3ViIjoiOCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.T7rKIwpMcluhMI-Zi5qgAec_ceJ8ha4JjHb2u6rdjPU"
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
  CustomerModel? customerModel;
  void getCustomerData(catId) {
    emit(LoadingCustomer());
    Map<String, dynamic> data = {"category_id": catId};
    DioHelper.postData(url: getCustomer, data: data).then((value) {
      customerModel = CustomerModel.fromJson(value.data);
      print("done Cat model ${splashModel!.status}");
      emit(DoneCustomer());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorCustomer());
    });
  }
}
