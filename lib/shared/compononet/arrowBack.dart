import 'package:flutter/material.dart';
import 'package:shopping/shared/my_colors.dart';

class MyArrowBack extends StatelessWidget {
  Function onPress;
  MyArrowBack({Key? key,  required this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(elevation: 4,
      shape: const StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      child: IconButton(
          icon: Icon(Icons.arrow_forward_ios, color: myBlack), onPressed:()=>onPress()),);
  }
}
