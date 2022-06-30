import 'package:cached_network_image/cached_network_image.dart';
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
        final splashModel=ShopCubit.get(context).splashModel;
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
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.50,
                child: CachedNetworkImage(
                  imageUrl: splashModel!.data!.splash.toString(),
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
              const SizedBox(height: 5,),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlueButton(title: "ابدأ التسوق",hight:0.08 ,width: 0.80,icon: Icons.arrow_back,
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
