import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/model/ProductsCustomer.dart';
import 'package:shopping/model/Stactic.dart';
import 'package:shopping/model/cart.dart';
import 'package:shopping/model/latest_product.dart';
import 'package:shopping/model/user_model.dart';
import 'package:shopping/modules/Customer/cubit/state.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/network.dart';
import 'package:shopping/shared/shared_prefernces.dart';

class CustomerCubit extends Cubit<CustomerStates> {
  CustomerCubit() : super(Customer_InitalState());
  static CustomerCubit get(context) => BlocProvider.of(context);

// ignore: non_constant_identifier_names

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

  ////////////////////////////Update Customer////////////////
  MultipartFile? mFile;
  updateCustomer({nameStore,nameStoreEn ,name,nameEn, pass, phone, adress, img, context}) async {
    emit(WaitingCustomerUpdtatingState());
    Map<String, dynamic> header = {
      "auth-token": ShopCubit.get(context).customerToken,
    };
    FormData formData = FormData.fromMap({
      "user_id": ShopCubit.get(context).customerId,
      "name_ar": name,
      "password": pass,
      "name_en": nameEn,
      "phone": phone,
      "address": adress,
      "longitude": 456,
      "latitude": 468456,
      "title_ar": nameStore,
      "title_en": nameStoreEn,
      "male": colorMen,
      "female": colorWomen,
      "baby": colorBaby,
      "logo": img
    });
    DioHelper.postData1(url: updateUser, data: formData, option: header)
        .then((value) {
      if(value.data['status']==true) {
        emit(CustomerUpdatingSucessState());
      }
      else{
        emit(CustomerUpdatingErrorDataState(value.data['msg']));
      }
      debugPrint(value.data.toString());
    }).catchError((error) {
      emit(CustomerUpdatingErrorState());
      print(error.toString());
    });
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
  ///////////////Latest Products/////////////////////


  //////////////////////////Stactic////////////

  Statistics? modelStatis;
  Future getStatisticCustomer(id, context) async {
    emit(GettingStatisticLoading());
    ShopCubit.get(context).getMyShared();
    Map<String, dynamic> data = {
      "user_id": id,
      "auth-token": ShopCubit.get(context).customerToken
    };
    Map<String, dynamic> header = {
      "auth-token": ShopCubit.get(context).customerToken
    };
    await DioHelper.postData(url: statistics, data: data, option: header)
        .then((value) {
      modelStatis = Statistics.fromJson(value.data);
      print("Done static");
      emit(GettingStatisticSucess());
    }).catchError((error) {
      print("stastic: ${error.toString()}");
      emit(GettingStatisticError());
    });
  }
  //////////////////Fav////////////

}
