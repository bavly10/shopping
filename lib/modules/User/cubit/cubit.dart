import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/model/CustomerModel.dart';
import 'package:shopping/modules/User/cubit/states.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';

import '../../../model/user_model.dart';
import '../../../shared/network.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(User_InitalState());
  static UserCubit get(context) => BlocProvider.of(context);
}
