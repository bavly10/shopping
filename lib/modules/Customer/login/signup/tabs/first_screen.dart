import 'package:flutter/material.dart';
import 'package:myshoop/modules/Customer/login/cubit/cubit.dart';
import 'package:myshoop/shared/compononet/textField.dart';
import 'package:myshoop/shared/error_compon.dart';
import 'package:myshoop/shared/localization/translate.dart';

class FirstScreen extends StatelessWidget {
  static TextEditingController namecontroller=TextEditingController();
  static TextEditingController namecontrollerEn=TextEditingController();
  static TextEditingController emailcontroller=TextEditingController();
  static TextEditingController passcontroller=TextEditingController();
  static GlobalKey<FormState> formFirst = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formFirst,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextField(validate: (String? s) {
            if (s!.isEmpty) return mytranslate(context, "validateName");
          },  readonly: false,label:mytranslate(context,"name"),controller: namecontroller,prefix: Icons.account_circle,type: TextInputType.text, obcure: false,),
          MyTextField(validate: (String? s) {
            if (s!.isEmpty) return mytranslate(context, "validateName");
          },  readonly: false,label:mytranslate(context,"nameEn"),controller: namecontrollerEn,prefix: Icons.account_circle,type: TextInputType.text, obcure: false,),
          const SizedBox(height: 25,),
          MyTextField(  readonly: false,validate:(value)  {if (value!.isEmpty) return mytranslate(context, "validateEmail");},label:mytranslate(context,"hintogin"),controller: emailcontroller,prefix: Icons.email_outlined,type: TextInputType.emailAddress,obcure: false),
          const SizedBox(height: 25,),
          MyTextField(
              validate: (String? s) {
                if (s!.isEmpty) return mytranslate(context, "validatePass");
              },
            readonly: false,
              label: mytranslate(context, "hintpassword"),
              controller: passcontroller,
              prefix: Icons.lock,
              type: TextInputType.text, obcure: true,
             ),
        ],
      ),
    );
  }
}
