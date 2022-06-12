import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/login/cubit/state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(Shop_InitalState());

  static LoginCubit get(context) => BlocProvider.of(context);
// ignore: non_constant_identifier_names
}