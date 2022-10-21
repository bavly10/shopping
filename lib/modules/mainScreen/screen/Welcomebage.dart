import 'package:flutter/material.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const  EdgeInsetsDirectional.all(12),
      margin: const EdgeInsetsDirectional.all(15),
      decoration: BoxDecoration(color: myBlue,borderRadius: BorderRadius.circular(45)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text(mytranslate(context, "wel"),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: myWhite,letterSpacing: 1),),
          const Image(
           image:  ExactAssetImage("assets/ch.png")),
          Padding(padding:const EdgeInsetsDirectional.all(12),child:  Text("Choose Your Best Category From above",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: myWhite),),),
        ],
      ),
    );
  }
}


