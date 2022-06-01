import 'package:flutter/material.dart';
import 'package:shopping/modules/mainScreen/mainScreen.dart';
import 'package:shopping/modules/onBoarding/onBoarding_screen.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/tsClip.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class onBoardingItem extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  final PageController index;
  final int lisIndex;
  onBoardingItem({Key? key, required this.onBoardingModel,required this.index,required this.lisIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: MediaQuery.of(context).size.height *.30,
            width:double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(45.0),image: DecorationImage(image: ExactAssetImage(onBoardingModel.image,))),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SmoothPageIndicator(
            effect: WormEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor:myBlue,
              spacing: 20,
              dotColor:myBlack,
            ),
            controller:index,
            count: lisIndex,
          ),
        ),
        const Spacer(),
        BlueButton(title: onBoardingModel.title, onpress: (){
          navigateTo(context, const MainScreen());
        })
      ],
    );
  }
}
