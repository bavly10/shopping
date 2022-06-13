import 'package:flutter/material.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class MyRowLogin extends StatelessWidget {
  final String lable1,lable2;
  void Function() ontab;
   MyRowLogin({Key? key,required this.lable1,required this.lable2, required this.ontab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(mytranslate(context, lable1)),
        InkWell(onTap: ontab, child:  Text(mytranslate(context, lable2),style: TextStyle(color: myBlue,fontWeight: FontWeight.bold),))
      ],
    );
  }
}
