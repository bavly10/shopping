import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/model/responceModel.dart';
import 'package:shopping/modules/login/cubit/state.dart';
import 'package:shopping/modules/login/signup/tabs/first_screen.dart';
import 'package:shopping/modules/login/signup/tabs/four_screen.dart';
import 'package:shopping/modules/login/signup/tabs/second_screen.dart';
import 'package:shopping/modules/login/signup/tabs/third_screen.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/network.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(Shop_InitalState());

  static LoginCubit get(context) => BlocProvider.of(context);
// ignore: non_constant_identifier_names

  List<Widget> myList = [
    FirstScreen(),
    SecondScreen(),
    ThirdScreen(),
    const FourScreen(),
  ];

  bool changeSCreen = true;
  void getChangeSCreen() {
    changeSCreen = !changeSCreen;
    emit(ShopChangeSCreens());
  }

  bool changeColorMen = false;
  int colorMen = 0;
  bool changeColorWomen = false;
  int colorWomen = 0;
  bool changeColorBaby = false;
  int colorBaby = 0;

  void getChangeColorMen() {
    changeColorMen = !changeColorMen;
    if(changeColorMen) {
      colorMen = 1;
    }else{
      colorMen = 0;
    }
    emit(ShopChangeSCreens());
  }

  void getChangeColorWomen() {
    changeColorWomen = !changeColorWomen;
    if(changeColorWomen){
    colorWomen = 1;
    }else{
    colorWomen = 0;
    }
    emit(ShopChangeColorsWomMen());
  }

  void getChangeColorBaby() {
    changeColorBaby = !changeColorBaby;

    if(changeColorBaby){
    colorBaby = 1;
    }else{
    colorBaby = 0;
    }
    emit(ShopChangeColorsBaby());
  }

  int changepager = 0;
  void changeindexpager(int val) {
    changepager = val;
    emit(ShopChangeNext());
  }

  bool lastIndex = false;
  void getLastIndex(val) {
    if (val == myList.length - 1) {
      lastIndex = true;
      emit(ShopChangelast());
    } else {
      lastIndex = false;
      emit(ShopChangedone());
    }
  }

  IconData iconVisiblity = Icons.visibility;

  bool isPassword = true;
  void changPasswordVisibilty() {
    isPassword = !isPassword;
    iconVisiblity =
        isPassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(ShopChangeiconpassword());
  }

  final picker = ImagePicker();
  var pickedFile;
  File? imagee;
  Future getImageBloc(ImageSource src) async {
    pickedFile = await picker.pickImage(source: src, imageQuality: 50);
    if (pickedFile != null) {
      imagee = File(pickedFile.path);
      emit(TakeImage_State());
      print("image selected");
    } else {
      print("no image selected");
    }
  }

  deleteImageBlocLogin() {
    imagee = null;
    emit(DeleteImage_State());
    print("image Deleted");
  }

  MultipartFile? mFile;
  ResponseModel? res;
  void signUp() async {
    emit(LoadingSignupState());
     FormData formData = FormData.fromMap({
      "name_ar": FirstScreen.namecontroller.text,
      "name_en": "s",
      "email": FirstScreen.emailcontroller.text,
      "password": FirstScreen.passcontroller.text,
      "phone": SecondScreen.mobilecontroller.text,
      "address": SecondScreen.addresscontroller.text,
      "longitude": 456,
      "latitude": 468456,
      "title_ar": ThirdScreen.storecotroller.text,
      "title_en": "s",
      "male": colorMen,
      "female": colorWomen,
      "baby": colorBaby,
      "logo": await MultipartFile.fromFile(imagee!.path,
          filename: mFile.toString(), contentType: MediaType("png", "jpg")),
    });
    DioHelper.postData1(url: signup, data: formData).then((value) {
      print(value.data.toString());
      res=ResponseModel.fromJson(value.data);
      emit(SucessSignupState(res!));

    }).catchError((error) {
      emit(ErrorSignupState(error.toString()));
      print(error.toString());
    });
  }
}
