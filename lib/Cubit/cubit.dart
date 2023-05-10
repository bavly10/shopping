import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshoop/Cubit/states.dart';
import 'package:myshoop/model/ProCustomer.dart';
import 'package:myshoop/model/ProductsCustomer.dart';
import 'package:myshoop/model/categoryModel.dart';
import 'package:myshoop/model/latest_product.dart';
import 'package:myshoop/model/privacy_policy.dart';
import 'package:myshoop/model/splash.dart';
import 'package:myshoop/model/version.dart';
import 'package:myshoop/modules/Customer/login/main.dart';

import 'package:myshoop/modules/cart/cart.dart';
import 'package:myshoop/modules/mainScreen/Setting/setting.dart';
import 'package:myshoop/modules/mainScreen/screen/HomeScreen.dart';
import 'package:myshoop/shared/Api/api.dart';
import 'package:myshoop/shared/diohelper/dioHelpoer.dart';
import 'package:myshoop/shared/network.dart';
import 'package:myshoop/shared/shared_prefernces.dart';
import 'package:sqflite/sqflite.dart';

import '../model/shippingcompanies.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(Shop_InitalState());
  static ShopCubit get(context) => BlocProvider.of(context);
  // ignore: non_constant_identifier_names
  Locale? locale_cubit;
  String? lang="en";
  static bool xtranslate = false;

  void changeLang(lang) async {
    Locale currentLocale = await setLocale(lang.lang_Code);
    changLocale(currentLocale);
  }

  changLocale(Locale currentLocale) {
    locale_cubit = currentLocale;
  }

  Future<Locale> locale(String lang) async {
    emit(cons_Change_Loading());
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
    print(locale_cubit);
    return locale_cubit!;
  }

  Future<Locale> setLocale(String langCode) async {
    await CashHelper.putData("locale", langCode);
    return locale(langCode);
  }

  Future<Locale> getLocale()async{
    if(lang==null){
      lang = "ar";
    }else{
      lang = CashHelper.getData("locale");
    }
    return locale(lang!);
  }

  int currentindex = 0;
  List<Widget> screen = [HomeScreen(), MainLogin(),Setting()];

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


//////////////////////////splash///////////
  SplashModel? splashModel;
  Future<void> getSplashData() async {
    emit(LoadingSplash());
    Map<String,dynamic> data=await Api().get(splash);
    splashModel = SplashModel.fromJson(data);
    if(splashModel!.status==true){
      emit(DoneSplash());
    }else{
      emit(ErrorSplash());
    }
  }

  //////////////////////////
  CategoryModel? categoryModel;
  List<String> type = ["male", "female", "baby"];
  Future<void> getCategoriesData(type) async {
    emit(LoadingCat());
    Map<String, dynamic> data = {"type": type};
    DioHelper.postData(url: category, data: data).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(DoneCat());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorCat());
    });
  }

  /////////////
  int? selected = 0;
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
      if (prosCustomerModel!.data!.isEmpty) {
        emit(emptyProCustomerState());
      } else {
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
  int? userId;
  void getMyShared() {
    customerToken = CashHelper.getData("customerToken");
    customerId = CashHelper.getData("customerId");
    userId = CashHelper.getData("userId");
  }

/////////////Search Cateogries////////////
  List<CatItem> searchCat = [];
  List<dynamic> searchCateogry(String quary) {
    searchCat = [];
    var searching = categoryModel!.data!
        .where((element) =>
            element.title!.toLowerCase().contains(quary.toLowerCase()))
        .toList();
    searchCat = searching;
    // print(search[0].title);
    emit(SearchingCustomer());
    return searchCat;
  }

  bool privacyy = false;
  void changePrivacyChecked(bool v) {
    privacyy = !privacyy;

    emit(ChangedPrivacyState());
  }

  int? counter = 0;
  getCurrentIndex(index) {
    counter = index;

    emit(ChangeButtonText());
  }

  List<ProductsItem> list = [];
  List<ProductsItem> lists = [];
  int pageCurrent = 1;
  int pagnationDataCurrent() {
    return pageCurrent += 1;
  }
  Future getProductCustomer(id) async {
    emit(ProductCustomerLoading());
    list = [];
    Map<String, dynamic> data = {"user_id": id};
    await DioHelper.postData(url: getProducts, data: data).then((value) {
      final res = value.data['data']['data'];
      if (res.isEmpty) {
        emit(ProductCustomerNull());
        pageCurrent = 1;
      } else {
        for (var value in res) {
          final pro = list.indexWhere((element) => element.id == value["id"].toString(),);
          if (pro >= 0) {
            list[pro] = ProductsItem(
              id: value["id"].toString(),
              title: value["title"],
              price: value["price"],
              desc: value["desc"],
              image: value["image"],
            );
            lists[pro] = ProductsItem(
              id: value["id"].toString(),
              title: value["title"],
              price: value["price"],
              desc: value["desc"],
              image: value["image"],
            );
          } else {
            list.add(ProductsItem(
              id: value["id"].toString(),
              title: value["title"],
              price: value["price"],
              desc: value["desc"],
              image: value["image"],
            ));
            lists.add(ProductsItem(
              id: value["id"].toString(),
              title: value["title"],
              price: value["price"],
              desc: value["desc"],
              image: value["image"],
            ));
          }
        }
        emit(ProductCustomerDone());
      }
    }).catchError((error) {
      print(error.toString());
      emit(ProductCustomerFail());
    });
  }
  Future getProductCustomerPagination(id) async {
    emit(ProductCustomerLoading());
    Map<String, dynamic> data = {"user_id": id, "page": pageCurrent};
    await DioHelper.postData(url: getProducts, data: data).then((value) {
      final res = value.data['data']['data'];
      if (res.isEmpty) {
        emit(ProductCustomerNullPagi());
        pageCurrent = 1;
      } else {
        for (var value in res) {
          final pro = lists.indexWhere(
                (element) => element.id == value["id"].toString(),
          );
          if (pro >= 0) {
            lists[pro] = ProductsItem(
              id: value["id"].toString(),
              title: value["title"],
              price: value["price"],
              desc: value["desc"],
              image: value["image"],
            );
          } else {
            lists.add(ProductsItem(
              id: value["id"].toString(),
              title: value["title"],
              price: value["price"],
              desc: value["desc"],
              image: value["image"],
            ));
          }
        }
        emit(ProductCustomerDonePagi());
      }
    }).catchError((error) {
      print(error.toString());
      emit(ProductCustomerFailPagi());
    });
  }
  LatestProduct? latestProduct;
  List<LatestProductItem> latestPro = [];
  Future latestproducts({id}) async {
    emit(LoadingLatestProduct());
    Map<String, dynamic> data = {"user_id": id};
    latestPro = [];
    await DioHelper.postData(url: latestProducts, data: data).then((value) {
      latestProduct = LatestProduct.fromMap(value.data);
      // print(latestPro);
      final res = value.data['data'];
      for (var value in res) {
        final pro = latestPro.indexWhere(
              (element) => element.id == value["id"],
        );
        if (pro >= 0) {
          latestPro[pro] = LatestProductItem(
              image: value["image"],
              price: value["price"],
              title: value["title"],
              id: value["id"],
              desc: value["desc"],
              userId: value["user_id"]);
        } else {
          latestPro.add(LatestProductItem(
              image: value["image"],
              price: value["price"],
              title: value["title"],
              id: value["id"],
              desc: value["desc"],
              userId: value["user_id"]));
        }
      }
      emit(GettingLatestProductSucess());
    }).catchError((error) {
      print(error.toString());
      emit(GettingLatestProductError());
    });
  }

  List<ProductsItem> search = [];
  List<dynamic> searchCustomer(String quary) {
    search = [];
    var searching = list
        .where((element) =>
        element.title!.toLowerCase().contains(quary.toLowerCase()))
        .toList();
    search = searching;
    // print(search[0].title);
    emit(SearchingProduct());
    return search;
  }

///////////////SqLite////////////////
  Database? db;
  List<Map> favItem=[];
  bool isFav=false;
  void createDatabase() {
    openDatabase("Kashtak.db", version: 1,
        onCreate: (database, verison) {
          print("database is created");
          database
              .execute(
              'CREATE TABLE fav (id INTEGER PRIMARY KEY, title TEXT, idPro TEXT,price TEXT,img TEXT,status TEXT )')
              .then((value) {
            print("table created");
          }).catchError((onError) {
            print("erros in crate teable ${onError.toString()}");
          });
        }, onOpen: (database) {
          getdatabase(database);
          print("database is open");
        }).then((value){
      db=value;
      emit(AppCreateDatabaseState());
    });
  }
  String? idProFav;
  void getdatabase(db){
    favItem=[];
    emit(AppGetDatabaseloadingState());
    db.rawQuery("SELECT * FROM fav").then((value) {
      value.forEach((element) {
        if(element['status']=="new")
        {
          idProFav=element["idPro"];
          favItem.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }
  Future insertDatabase({required String title, proid, price,img})  async{
    final pro = favItem.indexWhere((element) => idProFav == proid);
    if (pro >= 0) {
      emit(AppInsertsDatabaseState());
    }else{
      await db!.insert("fav", {
        "title": title,
        "idPro": proid,
        "price": price,
        "img":img,
        "status": "new",
      }).then((value) {
        isFav=true;
        emit(AppInsertDatabaseState());
        print("$value inster tmam,${title}");
        getdatabase(db);
      }).catchError((onError) {
        print("error fel insert $onError");
      });
    }
  }
  Future<int> deleteDatabase({required int id})  async{
    return await db!.rawDelete('DELETE FROM fav WHERE id = ?', [id]).whenComplete(() => {
      getdatabase(db),
      emit(AppDeletDatabaseState())
    }
    );
  }
  int? iconHeart;
  void changeColor(int i){
    iconHeart=i;
    emit(ColorProduct());
  }
  int? cartHeart;
  void changeCart(int i){
    cartHeart=i;
    emit(ColorProduct());
  }

  /////////////////newVersion/////////

  Version? version;
  int x=1;
  Future<void> getVersion() async {
    emit(LoadingVersion());
    DioHelper.getData(url: versionn).then((value) {
      version = Version.fromJson(value.data);
      debugPrint("done version model ${version!.data.ver}");
      emit(SuccessVersion());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(FailVersion());
    });
  }
}
