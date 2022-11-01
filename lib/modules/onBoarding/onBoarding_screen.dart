import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/splash.dart';
import 'package:shopping/modules/onBoarding/widget/on_boarding_item.dart';
import 'package:shopping/shared/compononet/LoagingDialog.dart';
import 'package:shopping/shared/compononet/error_page.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/compononet/blueButton.dart';
import '../../shared/compononet/componotents.dart';
import '../Customer/customer_home_screen.dart';
import '../mainScreen/mainScreen.dart';

class OnBoardingScreen extends StatelessWidget {
  PageController curnnetindex = PageController();
  String? x;
  @override
  Widget build(BuildContext context) {
    final splashModel = ShopCubit.get(context).splashModel;
    List textbtn = ["men", "Women", "baby"];
    List mylist = [
      onBoardingItem(
          splashModel: splashModel!.data!.male.toString(),
          index: curnnetindex,
          lisIndex: 3,
          lable: "men"),
      onBoardingItem(
          splashModel: splashModel.data!.female.toString(),
          index: curnnetindex,
          lisIndex: 3,
          lable: "Women"),
      onBoardingItem(
          splashModel: splashModel.data!.baby.toString(),
          index: curnnetindex,
          lisIndex: 3,
          lable: "baby"),
    ];
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (ctx, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: myWhite,
            // ignore: unnecessary_null_comparison
            body: splashModel == null
                ? const ErrorPage()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Image(
                            height: .10.h,
                            width: double.infinity,
                            image: const ExactAssetImage("assets/logo.png")),
                        Text(mytranslate(context, "splash_screenText1"),
                            style: TextStyle(
                                color: myBlack,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        Text(mytranslate(context, "splash_screenText2"),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(color: myBlack, fontSize: 18)),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: PageView.builder(
                              onPageChanged: (value) {
                                ShopCubit.get(context).getCurrentIndex(value);
                              },
                              itemCount: 3,
                              controller: curnnetindex,
                              itemBuilder: (context, index) {
                                return mylist[index];
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SmoothPageIndicator(
                            effect: WormEffect(
                              dotHeight: 10,
                              dotWidth: 10,
                              activeDotColor: myBlue,
                              spacing: 30,
                              dotColor: myBlack,
                            ),
                            controller: curnnetindex,
                            count: 3,
                          ),
                        ),
                        BlueButton(
                            title: Text(
                                mytranslate(context,
                                    textbtn[ShopCubit.get(context).counter!]),
                                style: TextStyle(
                                    color: myWhite,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            hight: 0.09,
                            width: 0.80,
                            icon: Icons.arrow_back,
                            onpress: () {
                              ShopCubit.get(context).getMyShared();
                              if (ShopCubit.get(context).customerToken == null) {
                                ShopCubit.get(context).getCategoriesData(ShopCubit.get(context).type[ShopCubit.get(context).counter!])
                                    .then(
                                      (value) => navigateTo(context, const MainScreen()),
                                    );
                              } else {
                                navigateToFinish(
                                    context,
                                    CustomerHome(
                                      id: ShopCubit.get(context).customerId,
                                    ));
                              }
                            })
                      ]),
          ),
        );
      },
    );
  }
}
