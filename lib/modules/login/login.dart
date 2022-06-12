import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/textField.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import 'signup/signup.dart';

class Login extends StatelessWidget {
   TextEditingController emailcontroller=TextEditingController();
   TextEditingController passcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit,ShopStates>(
      builder: (ctx,state){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(mytranslate(context,"loginText1"),style: TextStyle(color:myBlack,fontSize: 22 ,fontWeight: FontWeight.bold),),
              const SizedBox(height: 25,),
              Text(mytranslate(context,"loginText2",),style: TextStyle(color:myBlue,fontSize: 18 ),),
              const SizedBox(height: 25,),
              MyTextField(label: "Email",controller: emailcontroller,prefix: Icons.account_circle,type: TextInputType.text,obcure: false),
              const SizedBox(height: 25,),
              MyTextField(label: "Password",controller: passcontroller,prefix: Icons.account_circle,type: TextInputType.text,obcure: false),
              const SizedBox(height: 25,),
              TextButton(onPressed: (){}, child: Text(mytranslate(context, "ForgetPassword"),style: TextStyle(color: myBlue,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),)),
              const SizedBox(height: 25,),
              BlueButton(onpress: (){},title: mytranslate(context, "loginText2"), hight: 0.08, width: 0.80,),
              const SizedBox(height: 25,),
              myRow(context)
            ],
          ),
        );
      },
    );
  }
  Widget myRow(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(mytranslate(context, "text1")),
        InkWell(onTap: (){
          navigateTo(context, Signup());
        }, child:  Text(mytranslate(context, "signup"),style: TextStyle(color: myBlue,fontWeight: FontWeight.bold),))
      ],
    );
  }
}
