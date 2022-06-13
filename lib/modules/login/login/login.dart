import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/modules/login/cubit/cubit.dart';
import 'package:shopping/modules/login/cubit/state.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/rowLogin.dart';
import 'package:shopping/shared/compononet/textField.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import '../signup/signup.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
   TextEditingController emailcontroller=TextEditingController();
   TextEditingController passcontroller=TextEditingController();
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit,LoginStates>(
      builder: (ctx,state){
        final cubit=LoginCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SizedBox(height:MediaQuery.of(context).size.height*0.10,),
                Text(mytranslate(context,"loginText1"),style: TextStyle(color:myBlack,fontSize: 22 ,fontWeight: FontWeight.bold),),
                const SizedBox(height: 25,),
                Text(mytranslate(context,"loginText2",),style: TextStyle(color:myBlue,fontSize: 18 ),),
                const SizedBox(height: 25,),
                MyTextField(label: mytranslate(context, "hintogin"),controller: emailcontroller,prefix: Icons.account_circle,type: TextInputType.text,obcure: false),
                const SizedBox(height: 25,),
                MyTextField(label: mytranslate(context, "hintpassword"),controller: passcontroller,prefix: Icons.account_circle,type: TextInputType.text,obcure: cubit.isPassword,suffix: cubit.iconVisiblity,suffixPressed: (){
                  cubit.changPasswordVisibilty();
                }),
                const SizedBox(height: 25,),
                TextButton(onPressed: (){}, child: Text(mytranslate(context, "ForgetPassword"),style: TextStyle(color: myBlue,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),)),
                const SizedBox(height: 25,),
                BlueButton(onpress: (){},title: mytranslate(context, "loginText2"), hight: 0.08, width: 0.80,),
                const SizedBox(height: 25,),
                MyRowLogin(lable1: "text1", lable2: "signup", ontab: (){LoginCubit.get(context).getChangeSCreen();})
              ],
            ),
          ),
        );
      },
    );
  }
}
