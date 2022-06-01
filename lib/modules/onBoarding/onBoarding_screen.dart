import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/Cubit/states.dart';
import 'package:shopping/modules/onBoarding/widget/on_boarding_item.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class OnBoardingModel {
  String image;
  String title;
  OnBoardingModel({
    required this.image,
    required this.title,
  });
}


class OnBoardingScreen extends StatelessWidget {

  List<OnBoardingModel> onBoardingmodel = [
    OnBoardingModel(
        title: 'رجالي',
        image: 'assets/1.png'),
    OnBoardingModel(
        title: 'حريمي ',
        image: 'assets/1.png'),
    OnBoardingModel(
        title: 'اطفالي',
        image: 'assets/1.png'),
  ];
  PageController curnnetindex=PageController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit,ShopStates>(
      builder: (ctx,state){
        return  Scaffold(
          backgroundColor: myWhite,
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(height:MediaQuery.of(context).size.height * 0.30,width: double.infinity,image: ExactAssetImage("assets/logo.png")),
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
                    /// CachedNetworkImage(
                    //     CachedNetworkImage(
                    //                 imageUrl: e.image,
                    //                 fit: BoxFit.fill,
                    //                 imageBuilder: (context, imageProvider) =>
                    //                     Container(
                    //                       decoration: BoxDecoration(
                    //                         borderRadius: const BorderRadius.only(
                    //                             bottomLeft: Radius.circular(25.0),
                    //                             bottomRight:
                    //                             Radius.circular(25.0)),
                    //                         image: DecorationImage(
                    //                           image: imageProvider,
                    //                           fit: BoxFit.fill,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                 placeholder: (context, url) => CircularProgressIndicator(color: myBlue,),
                    //                 errorWidget: (context, url, error) =>
                    //                 const Icon(Icons.error),
                    //               )).toList(),
                      itemCount: onBoardingmodel.length,
                      controller: curnnetindex,
                      itemBuilder: (context, index) {
                        return onBoardingItem(onBoardingModel: onBoardingmodel[index],index: curnnetindex,lisIndex:onBoardingmodel.length,);
                      }),
                ),
              ]),
        );
      },
    );
  }

}
