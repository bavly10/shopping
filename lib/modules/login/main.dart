import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/login/cubit/cubit.dart';
import 'package:shopping/modules/login/cubit/state.dart';
import 'package:shopping/modules/login/login/login.dart';
import 'package:shopping/modules/login/signup/signup.dart';

class MainLogin extends StatelessWidget {
  const MainLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit,LoginStates>(
      builder: (ctx,state){
        final cubit=LoginCubit.get(context).changeSCreen;
        if(cubit){
          return Login();
        }else{
          return Signup();
        }
      },
    );
  }
}
