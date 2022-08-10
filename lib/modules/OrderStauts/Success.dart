import 'package:flutter/material.dart';
import 'package:shopping/shared/my_colors.dart';
class SuccessOrder extends StatelessWidget {
  final String phone;
  const SuccessOrder({Key? key,required this.phone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text("put image here"),
          const SizedBox(height: 10,),
          const Text("تم تنفيذ طلبك و جاري العمل عليه و سوف يتم اتصال علي رقم \n ",style: TextStyle(color: Colors.green)),
          Text(phone,style: TextStyle(color: myBlue),),
          const Text(" لتاكيد الطلب قبل الشحن من المتاجر الذي قمت باختيارهم",style: TextStyle(color: Colors.green))
        ],
      ),

    );
  }
}
