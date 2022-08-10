import 'package:flutter/material.dart';
import 'package:shopping/shared/my_colors.dart';
class FailedOrder extends StatelessWidget {
  const FailedOrder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: const [
          Text("put image here"),
          SizedBox(height: 10,),
          Text("تم فشل العمليه  \n ",style: TextStyle(color: Colors.red)),
        ],
      ),

    );
  }
}
