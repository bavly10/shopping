import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/modules/login/login/login.dart';
import 'package:shopping/modules/login/main.dart';
import 'package:shopping/modules/mainScreen/screen/HomeScreen.dart';
import 'package:shopping/modules/mainScreen/screen/cart.dart';
import 'package:shopping/shared/shared_prefernces.dart';
import 'package:http/http.dart' as http;

import '../modules/mainScreen/screen/products.dart';

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
    const Cart(),
    MainLogin()
  ];

  void changeIndex(int index) {
    currentindex = index;
    emit(ChangeIndexTabs());
  }
  bool changeAppBar=true;
  void changeSearchAppBar(){
    changeAppBar=!changeAppBar;
    emit(ChangeAppBar());
  }
}
