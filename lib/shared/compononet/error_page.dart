import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/modules/Splash_screen/splash.dart';
import 'package:shopping/modules/onBoarding/onBoardingFirst.dart';
import 'package:shopping/modules/onBoarding/onBoarding_screen.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/90.jpg"))),
            ),
          ),
          Text(
            mytranslate(context, "error"),
            style: TextStyle(
                color: myBlue, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          BlueButton(
            title: Text(
              mytranslate(context, "try"),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            hight: .05,
            width: .4,
            onpress: () {
              ShopCubit.get(context).getSplashData();
              ShopCubit.get(context).getCategoriesData();
              ShopCubit.get(context).getCustomerData(10);
              ShopCubit.get(context).getLocale();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const OnBoardingFirst()), // this mainpage is your page to refresh
                (Route<dynamic> route) => true,
              ).then((value) {});
            },
          )
        ],
      ),
    );
  }
}
