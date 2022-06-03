import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/language.dart';
import 'package:shopping/modules/onBoarding/onBoarding_screen.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/componotents.dart';

class OnBoardingFirst extends StatelessWidget {
  const OnBoardingFirst({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit,ShopStates>(
      builder: (ctx,state){
        final cubit=ShopCubit.get(context);
        return Scaffold(
          appBar:  AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(opacity: 0),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: DropdownButton(
                  onChanged: (lang) {
                    cubit.changeLang(lang);
                  },
                  items: lanugage.lang_list
                      .map<DropdownMenuItem<lanugage>>(
                          (lang) => DropdownMenuItem(value: lang,
                        child: Row(
                          children: [
                            Text(lang.flag!),
                            const SizedBox(width: 10,),
                            Text(lang.name!)],
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
          body: Column(
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
          ),
        );
      },
    );
  }
}
