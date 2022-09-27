import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/model/language.dart';
import 'package:shopping/modules/onBoarding/onBoarding_screen.dart';
import 'package:shopping/shared/compononet/blueButton.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/compononet/error_page.dart';
import 'package:shopping/shared/diohelper/dioHelpoer.dart';
import 'package:shopping/shared/localization/translate.dart';

import '../../shared/my_colors.dart';

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
                          height: MediaQuery.of(context).size.height * 0.70,
                          child: CachedNetworkImage(
                            imageUrl: splashModel.splash.toString(),
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const Icon(Icons.downloading),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Spacer(),
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: BlueButton(
                                title: Text(mytranslate(context, "get"),
                                    style: TextStyle(
                                        color: myWhite,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                hight: 0.08,
                                width: 0.80,
                                icon: Icons.arrow_back,
                                onpress: () {
                                  // ProductCubit.get(context).getProducts(4);
                                  navigateToFinish(context, OnBoardingScreen());
                                  //   ProductCubit.get(context).showPro(39,context).then((value) => {
                                  // navigateTo(context, UpdateProduct(id: 39),)
                                  //   });
                                  //CashHelper.removeData("userId");
                                }))
                      ],
                    ),
        );
      },
    );
  }
}
