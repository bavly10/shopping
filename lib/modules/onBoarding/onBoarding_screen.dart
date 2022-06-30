import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/splash.dart';
import 'package:shopping/modules/onBoarding/widget/on_boarding_item.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class OnBoardingScreen extends StatelessWidget {
  PageController curnnetindex=PageController();
  String? x;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit,ShopStates>(
      builder: (ctx,state){
        final splashModel=ShopCubit.get(context).splashModel;
        List mylist=[
        onBoardingItem(splashModel:splashModel!.data!.male.toString(), index: curnnetindex, lisIndex:3,lable: "men"),
        onBoardingItem(splashModel:splashModel.data!.female.toString(), index: curnnetindex, lisIndex:3,lable:"Women" ),
        onBoardingItem(splashModel:splashModel.data!.baby.toString(), index: curnnetindex, lisIndex:3,lable:"baby" ),
        ];
        return  Scaffold(
          backgroundColor: myWhite,
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(height:MediaQuery.of(context).size.height * 0.10,width: double.infinity,image: ExactAssetImage("assets/logo.png")),
                Text(
                    mytranslate(context, "splash_screenText1"),
                    style: TextStyle(color: myBlack,fontSize: 24,fontWeight: FontWeight.bold)
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                    mytranslate(context, "splash_screenText2"),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: myBlack, fontSize: 18)),
                Expanded(
                  child: PageView.builder(
                      itemCount: 3,
                      controller: curnnetindex,
                      itemBuilder: (context, index) {
                        return mylist[index];
                      }),
                ),
              ]),
        );
      },
    );
  }

}
