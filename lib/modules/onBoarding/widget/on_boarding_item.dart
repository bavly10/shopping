import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping/modules/mainScreen/mainScreen.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class onBoardingItem extends StatelessWidget {
  String splashModel;
  String lable;
  final PageController index;
  final int lisIndex;
  onBoardingItem({Key? key, required this.splashModel,required this.index,required this.lisIndex,required this.lable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.50,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: splashModel,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,),
              ),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
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
        BlueButton(title:Text(mytranslate(context, lable),style: TextStyle(color: myWhite,fontSize: 18,fontWeight: FontWeight.bold)),hight:0.08 ,width: 0.80,icon: Icons.arrow_back, onpress: (){
          navigateTo(context, const MainScreen());
        })
      ],
    );
  }
}