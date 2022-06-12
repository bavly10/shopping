import 'package:flutter/material.dart';
import 'package:shopping/shared/compononet/textField.dart';

class FirstScreen extends StatelessWidget {
 TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyTextField(label: "Name",controller: controller,prefix: Icons.account_circle,type: TextInputType.text, obcure: false,),
        const SizedBox(height: 25,),
        MyTextField(label: "Email",controller: controller,prefix: Icons.account_circle,type: TextInputType.text,obcure: false),
        const SizedBox(height: 25,),
        MyTextField(label: "Password",controller: controller,prefix: Icons.account_circle,type: TextInputType.text,obcure: false),
      ],
    );
  }
}
