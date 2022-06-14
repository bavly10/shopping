import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/login/cubit/cubit.dart';
import 'package:shopping/shared/compononet/borderSignup.dart';
import 'package:shopping/shared/compononet/textField.dart';
import 'package:shopping/shared/localization/translate.dart';

import '../../cubit/state.dart';

class ThirdScreen extends StatelessWidget {
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit,LoginStates>(
      builder: (ctx,state){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(label:mytranslate(context,"namestore"),controller: controller,prefix: Icons.account_circle,type: TextInputType.text, obcure: false,),
            const SizedBox(height: 25,),
            myRow(context)
          ],
        );
      },
    );
  }
  Widget myRow(context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: (){
              LoginCubit.get(context).getChangeColorMen();
            },child: BorderSignup(color: LoginCubit.get(context).changeColorMen,lable:mytranslate(context,"men")),
          ),
          InkWell(
            onTap: (){
              LoginCubit.get(context).getChangeColorWomen();
            },child: BorderSignup(color: LoginCubit.get(context).changeColorWomen,lable:mytranslate(context,"Women")),
          ),
          InkWell(
            onTap: (){
              LoginCubit.get(context).getChangeColorBaby();
            },child: BorderSignup(color: LoginCubit.get(context).changeColorBaby,lable:mytranslate(context,"baby")),
          ),
        ],
      ),
    );
  }
}