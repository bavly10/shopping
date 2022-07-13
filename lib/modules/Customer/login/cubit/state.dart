import 'package:shopping/model/responceModel.dart';
import 'package:shopping/model/CustomerModel.dart';

abstract class LoginStates {}

class Shop_InitalState extends LoginStates {}

class ShopChangeSCreens extends LoginStates {}
class ShopChangeColorsMen extends LoginStates {}
class ShopChangeColorsWomMen extends LoginStates {}
class ShopChangeColorsBaby extends LoginStates {}
class ShopChangeNext extends LoginStates {}
class ShopChangedone extends LoginStates {}
class ShopChangelast extends LoginStates {}
class ShopChangeiconpassword extends LoginStates {}
class ChangeCity_Select extends LoginStates {}
class TakeImage_State extends LoginStates {}
class DeleteImage_State extends LoginStates {}
class LoadingSignupState extends LoginStates {}
class LoadingLoginState extends LoginStates {}
class SucessLoginState extends LoginStates {
  final CustomerModel response;
  SucessLoginState(this.response);}
class SucessSignupState extends LoginStates {
  final ResponseModel response;
SucessSignupState(this.response);}

class ErrorSignupState extends LoginStates {
  final String error;

  ErrorSignupState(this.error);
}
class ErrorLoginState extends LoginStates {
  final String error;
  ErrorLoginState(this.error);
}
