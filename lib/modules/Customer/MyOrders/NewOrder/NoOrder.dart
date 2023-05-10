import 'package:flutter/material.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';
import 'package:sizer/sizer.dart';
class NoOrders extends StatelessWidget {
  const NoOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40.h,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/empty.png"))),
        ),
        const SizedBox(height: 25,),
        Text(
          mytranslate(context, "noo"),
          style:const  TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        )
      ],
    );
  }
}
