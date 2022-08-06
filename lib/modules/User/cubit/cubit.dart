import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/model/CustomerModel.dart';
import 'package:shopping/modules/User/cubit/states.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';

import '../../../shared/network.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(User_InitalState());
  static UserCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  checkUser(phone) async {
    emit(Loadingchecking());

    Map<String, dynamic> phonen = {"phone": phone};
    await DioHelper.postData(
      url: checkCustomerPhone,
      data: phonen,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);

      emit(CheckingCustomerSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(CheckingCustomerErrorState());
    });
  }

  int? userId;
  createUser({email, phone, address, name}) async {
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
      userModel = UserModel.fromJson(value.data);

      emit(InsertCustomerSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(InsertCustomerErrorState());
    });
  }
}
