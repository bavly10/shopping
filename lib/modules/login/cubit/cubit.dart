import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping/modules/login/cubit/state.dart';
import 'package:shopping/modules/login/signup/tabs/first_screen.dart';
import 'package:shopping/modules/login/signup/tabs/four_screen.dart';
import 'package:shopping/modules/login/signup/tabs/second_screen.dart';
import 'package:shopping/modules/login/signup/tabs/third_screen.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(Shop_InitalState());

  static LoginCubit get(context) => BlocProvider.of(context);
// ignore: non_constant_identifier_names
  List<Widget> myList=[
    FirstScreen(),
    SecondScreen(),
    ThirdScreen(),
    FourScreen(),
  ];

  bool changeSCreen=true;
  void getChangeSCreen(){
    changeSCreen=!changeSCreen;
    emit(ShopChangeSCreens());
  }

  bool changeColorMen=false;
  bool changeColorWomen=false;
  bool changeColorBaby=false;

  void getChangeColorMen(){
    changeColorMen=!changeColorMen;
    emit(ShopChangeSCreens());
  }
  void getChangeColorWomen(){
    changeColorWomen=!changeColorWomen;
    emit(ShopChangeColorsWomMen());
  }
  void getChangeColorBaby(){
    changeColorBaby=!changeColorBaby;
    emit(ShopChangeColorsBaby());
  }

  int changepager = 0;
  void changeindexpager(int val) {
    changepager = val;
    emit(ShopChangeNext());
  }
  bool lastIndex=false;
  void getLastIndex(val){
    if (val == myList.length-1) {
      lastIndex=true;
      emit(ShopChangelast());
    }else{
      lastIndex=false;
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

}