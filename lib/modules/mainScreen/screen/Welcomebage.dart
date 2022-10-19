import 'package:flutter/material.dart';
import 'package:shopping/shared/my_colors.dart';
class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(12),
      margin: const EdgeInsetsDirectional.all(25),
      decoration: BoxDecoration(color: myWhite,borderRadius: BorderRadius.circular(45)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text("Welcome Sir",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: myBlue),),
          const Image(
           image:  ExactAssetImage("assets/ch.png")),
          Padding(padding:const EdgeInsetsDirectional.all(12),child:  Text("Choose Your Best Category From above",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: myBlack),),),
        ],
      ),
    );
  }
}
