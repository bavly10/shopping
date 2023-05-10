import 'package:flutter/material.dart';
import 'package:myshoop/shared/my_colors.dart';

class BorderSignup extends StatelessWidget {
  final bool color;
  final String lable;

  const BorderSignup({Key? key,required this.color,required this.lable}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color:color
                  ? myBlue
                  : Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          lable,
          style:color?const TextStyle(fontSize: 25,fontWeight:FontWeight.bold): const TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
