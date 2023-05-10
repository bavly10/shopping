import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshoop/modules/Customer/login/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/login/cubit/state.dart';
import 'package:myshoop/modules/Customer/login/login/login.dart';
import 'package:myshoop/modules/Customer/login/signup/signup.dart';
import 'package:myshoop/shared/compononet/privacy_signup.dart';
import 'package:myshoop/shared/my_colors.dart';

class MainLogin extends StatelessWidget {
  const MainLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit,LoginStates>(
      builder: (ctx,state){
        final cubit=LoginCubit.get(context).changeSCreen;
        return Scaffold(
          backgroundColor: myGrey,
          body: cubit? Login():Signup(),
        );
      },
    );
  }
}
