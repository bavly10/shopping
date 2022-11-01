import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/language.dart';
import 'package:shopping/modules/onBoarding/onBoarding_screen.dart';
import 'package:shopping/shared/compononet/MyCachedNetworkImage.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/error_page.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';
import 'package:sizer/sizer.dart';


class OnBoardingFirst extends StatelessWidget {
  const OnBoardingFirst({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var splashModel = ShopCubit.get(context).splashModel?.data;
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (ctx, state) {
        final cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(opacity: 0),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: DropdownButton(
                  onChanged: (lang) {
                    DioHelper.init();
                    cubit.changeLang(lang);
                  },
                  items: lanugage.lang_list
                      .map<DropdownMenuItem<lanugage>>(
                          (lang) => DropdownMenuItem(
                                value: lang,
                                child: Row(
                                  children: [
                                    Text(lang.flag!),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(lang.name!)
                                  ],
                                ),
                              ))
                      .toList(),
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.language,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
          body: state is cons_Change_Loading
              ? const CircularProgressIndicator()
              : splashModel == null
                  ? const ErrorPage()
                  : Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 60.h,
                          child: MyCachedNetWorkImage(logo: splashModel.splash!,radius: 25.0,),
                        ),
                        const Spacer(),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.h),
                            child: BlueButton(
                                title: Text(mytranslate(context, "get"),
                                    style: TextStyle(
                                        color: myWhite,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                hight: 0.09,
                                width: 0.80,
                                icon: Icons.arrow_back,
                                onpress: () {
                                navigateToFinish(context, OnBoardingScreen());
                                 // navigateToFinish(context, Maps());
                                }))
                      ],
                    ),
        );
      },
    );
  }
}
