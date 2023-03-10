import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:shopping/modules/mainScreen/mainScreen.dart';
import 'package:shopping/modules/onBoarding/onBoarding_screen.dart';
import 'package:shopping/modules/payment/cubit/cubit.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../shared/compononet/componotents.dart';
import '../cart/cart.dart';

class FailedOrder extends StatelessWidget {
  const FailedOrder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            HexColor(
              '#09C6F9',
            ),
            HexColor('#045DE9')
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  Icons.cancel_sharp,
                  color: myBlue,
                  size: 76,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(mytranslate(context, "fail"),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35)),
                    Text("${PaymentCubit.get(context).message}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
              ),
              TextButton(
                onPressed: (){
                  navigateToFinish(context, CartScreen());
                },
                child: Text(mytranslate(context, "again"),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
              Padding(
                padding: const EdgeInsets.all(27.0),
                child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * .5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      navigateTo(context,OnBoardingScreen());
                    },
                    textColor: myBlue,
                    color: Colors.white,
                    child: Text(
                      mytranslate(context, "ok"),
                      style: TextStyle(
                          color: myBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
