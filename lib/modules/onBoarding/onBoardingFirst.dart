import 'package:flutter/material.dart';
import 'package:shopping/modules/onBoarding/onBoarding_screen.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/componotents.dart';

class OnBoardingFirst extends StatelessWidget {
  const OnBoardingFirst({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          height: MediaQuery.of(context).size.height*0.50,
          width: double.infinity,
          image: const ExactAssetImage("assets/shopimg.png"),
        ),
        const SizedBox(height: 5,),
         Image(
           height: MediaQuery.of(context).size.height*0.10,
          width: double.infinity,
          image: const ExactAssetImage("assets/logo.png"),
        ),
        const SizedBox(height: 5,),
        const Spacer(),
         Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlueButton(title: "ابدأ التسوق",
              onpress:(){
           navigateToFinish(context, OnBoardingScreen());
          }),
        )
      ],
    );
  }
}
