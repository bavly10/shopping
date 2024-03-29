import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshoop/modules/Customer/login/cubit/cubit.dart';
import 'package:myshoop/modules/Customer/login/cubit/state.dart';
import 'package:myshoop/shared/compononet/borderSignup.dart';
import 'package:myshoop/shared/compononet/textField.dart';
import 'package:myshoop/shared/localization/translate.dart';

class ThirdScreen extends StatelessWidget {
  static TextEditingController storecotroller=TextEditingController();
  static TextEditingController storecotrollerEn=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit,LoginStates>(
      builder: (ctx,state){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(validate: (String? s) {
              if (s!.isEmpty) return mytranslate(context, "validateStore");
            },  readonly: false,label:mytranslate(context,"namestore"),controller: storecotroller,prefix: Icons.account_circle,type: TextInputType.text, obcure: false,),
            MyTextField(validate: (String? s) {
              if (s!.isEmpty) return mytranslate(context, "validateStore");
            },  readonly: false,label:mytranslate(context,"namestoreEn"),controller: storecotrollerEn,prefix: Icons.account_circle,type: TextInputType.text, obcure: false,),
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