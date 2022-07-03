import 'package:flutter/material.dart';
import 'package:shopping/shared/compononet/textField.dart';
import 'package:shopping/shared/localization/translate.dart';

class FirstScreen extends StatelessWidget {
  static TextEditingController namecontroller=TextEditingController();
  static TextEditingController emailcontroller=TextEditingController();
  static TextEditingController passcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTextField(label:mytranslate(context,"name"),controller: namecontroller,prefix: Icons.account_circle,type: TextInputType.text, obcure: false,),
        const SizedBox(height: 25,),
        MyTextField(label:mytranslate(context,"hintogin"),controller: emailcontroller,prefix: Icons.account_circle,type: TextInputType.text,obcure: false),
        const SizedBox(height: 25,),
        MyTextField(label:mytranslate(context,"hintpassword"),controller: passcontroller,prefix: Icons.account_circle,type: TextInputType.text,obcure: false),
      ],
    );
  }
}
