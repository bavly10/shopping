import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/model/ProductsCustomer.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/shared_prefernces.dart';

import '../../../Cubit/states.dart';
import '../../../model/CustomerModel.dart';
import '../../../model/ProCustomer.dart';
import '../../../model/user_model.dart';
import '../../../shared/network.dart';

class CustomerCubit extends Cubit<CustomerStates> {
  CustomerCubit() : super(Customer_InitalState());

  static CustomerCubit get(context) => BlocProvider.of(context);

// ignore: non_constant_identifier_names
  List<ProductsItem> list = [];

  Future getProductCustomer(id) async {
    emit(ProductCustomerLoading());
    list = [];
    Map<String, dynamic> data = {"user_id": id};
    await DioHelper.postData(url: getProducts, data: data).then((value) {
      final res = value.data['data'];
      for (var value in res) {
        final pro = list.indexWhere(
          (element) => element.id == value["id"].toString(),
        );
        if (pro >= 0) {
          list[pro] = ProductsItem(
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
        }
      }
      emit(ProductCustomerDone());
    }).catchError((error) {
      print(error.toString());
      emit(ProductCustomerFail());
    });
  }

  bool changeColorMen = false;
  int colorMen = 0;
  bool changeColorWomen = false;
  int colorWomen = 0;
  bool changeColorBaby = false;
  int colorBaby = 0;

  void getChangeColorMen() {
    changeColorMen = !changeColorMen;
    if (changeColorMen) {
      colorMen = 1;
    } else {
      colorMen = 0;
    }
    emit(ShopChangeMens());
  }

  void getChangeColorWomen() {
    changeColorWomen = !changeColorWomen;
    if (changeColorWomen) {
      colorWomen = 1;
    } else {
      colorWomen = 0;
    }
    emit(ShopColorsWomMen());
  }

  void getChangeColorBaby() {
    changeColorBaby = !changeColorBaby;

    if (changeColorBaby) {
      colorBaby = 1;
    } else {
      colorBaby = 0;
    }
    emit(ShopColorsBaby());
  }

  final picker = ImagePicker();
  var pickedFile;
  File? imagee, file;

  Future getImageBloc(ImageSource src) async {
    pickedFile = await picker.pickImage(source: src, imageQuality: 50);
    if (pickedFile != null) {
      imagee = File(
        pickedFile.path,
      );
      emit(TakeImageState());
      print("image selected");
    } else {
      print("no image selected");
    }
  }

  ////////////////////////Show Customer Data////////////////////
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
      // var raf = file?.openSync(mode: FileMode.write);
      // response.data is List<int> type
      print(prosCustomerModel!.data!.id!);
      emit(ShowingCustomerData());
    }).catchError((error) {
      print(error.toString());
      emit(FailShowCustomerData());
    });
  }

  ////////////////////////////Update Customer////////////////
  MultipartFile? mFile;
  updateCustomer({nameStore, name, pass, phone, adress, img, context}) async {
    emit(WaitingCustomerUpdtatingState());
    Map<String, dynamic> header = {
      // "auth-token":
      //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2thc2g1dGFrLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE2NTg2MDM4MDUsImV4cCI6MTY1OTIwODYwNSwibmJmIjoxNjU4NjAzODA1LCJqdGkiOiJ2VmlCQXpKbktGREI3YlZEIiwic3ViIjoiMTgiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.t-2RBvCKHkEbUmnRrRcF7eeH1lNGDxu4Py7SX6iLk1c"
      "auth-token": ShopCubit.get(context).customerToken,
    };
    FormData formData = FormData.fromMap({
      "user_id": ShopCubit.get(context).customerId,
      "name_ar": name,
      "password": pass,
      "name_en": prosCustomerModel!.data!.nameEn,
      "phone": phone,
      "address": adress,
      "longitude": 456,
      "latitude": 468456,
      "title_ar": nameStore,
      "title_en": prosCustomerModel!.data!.titleEn,
      "male": colorMen,
      "female": colorWomen,
      "baby": colorBaby,
      "logo": img
    });
    DioHelper.postData1(url: updateUser, data: formData, option: header)
        .then((value) {
      print(value.data.toString());

      emit(CustomerUpdatingSucessState());
    }).catchError((error) {
      emit(CustomerUpdatingErrorState());
      print(error.toString());
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

  User? userModel;
  bool? check;

  Future checkUser(phone) async {
    emit(Loadingchecking());
    Map<String, dynamic> phonen = {"phone": phone};
    await DioHelper.postData(
      url: checkCustomerPhone,
      data: phonen,
    ).then((value) {
      userModel = User.fromMap(value.data);
      if (userModel!.status == true) {
        CashHelper.putData("userId", userModel!.data);
        check = userModel!.status!;
        emit(CheckingCustomerSucessState());
      } else {
        check = userModel!.status!;
        emit(CheckingCustomerErrorState());
      }

      print(check);
    }).catchError((error) {
      print(error.toString());
      emit(CheckingCustomerErrorState());
    });
  }

  int? userId;
  Future createUser({email, phone, address, name}) async {
    Map<String, dynamic> data = {
      "phone": phone,
      "email": email,
      "address": address,
      "name": name
    };
    await DioHelper.postData(
      url: insertCustomer,
      data: data,
    ).then((value) {
      userModel = User.fromMap(value.data);
      if (userModel!.status == true) {
        userId = userModel!.data;
        CashHelper.putData("userId", userModel!.data);
        print(userModel!.data);
        emit(InsertCustomerSucessState());
      } else {
        emit(InsertCustomerErrorState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(InsertCustomerErrorState());
    });
  }

  connectStore({context, userId}) async {
    Map<String, dynamic> data = {
      "costomer_id": ShopCubit.get(context).userId,
      "user_id": userId,
    };
    await DioHelper.postData(
      url: moveCustomer,
      data: data,
    ).then((value) {
      print("for connect Store....${value.data}");

      print("connecting");
      emit(ConnectingShopSuecssState());
    }).catchError((error) {
      print(error.toString());
      emit(ConnectingShopErrorState());
    });
  }
}
