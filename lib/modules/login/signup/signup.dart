import 'package:flutter/material.dart';
import 'package:shopping/modules/login/signup/tabs/first_screen.dart';
import 'package:shopping/modules/login/signup/tabs/four_screen.dart';
import 'package:shopping/modules/login/signup/tabs/second_screen.dart';
import 'package:shopping/modules/login/signup/tabs/third_screen.dart';

import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Signup extends StatelessWidget {
  var pageController = PageController();
  List<Widget> myList=[
    FirstScreen(),
    SecondScreen(),
    ThirdScreen(),
    FourScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Padding(
         padding: const EdgeInsets.all(12.0),
         child: Column(children: [
           Text(mytranslate(context, "signup1"),style: TextStyle(color: myBlack,fontSize: 22,fontWeight: FontWeight.bold),),
           const SizedBox(height: 15,),
           Text(mytranslate(context, "signup2"),style: TextStyle(color: myBlue,fontSize: 18),),
           const SizedBox(height: 15,),
           Container(
             height: MediaQuery.of(context).size.height*0.40,
             width: double.infinity,
             color: Colors.white,
             child: PageView.builder(
               controller: pageController,
               physics: const BouncingScrollPhysics(),
               itemBuilder: (ctx, i) {
                 return myList[i];
               },
               itemCount: myList.length,
             ),
           ),
           const SizedBox(height: 15,),
           Center(child: mySmooth(),),
           const SizedBox(height: 15,),
           buttonNP()
         ],),
       ),
    );
  }
  Widget mySmooth(){
    return SmoothPageIndicator(
      controller:pageController,
      count: myList.length,
      effect: const ExpandingDotsEffect(
          expansionFactor: 4,
          dotColor: Colors.grey,
          dotWidth: 10,
          dotHeight: 10,
          spacing: 5.0),
    );
  }
  Widget buttonNP(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlueButton(title: "التالي",hight:0.09 ,width: 0.30,icon: Icons.arrow_back,
            onpress:(){
           print("donme");
            }),
        BlueButton(title: "رجوع",hight:0.08 ,width: 0.30,icon:  Icons.arrow_forward,
            onpress:(){
              print("doneeeee");
            }),
      ],
    );
  }
}
