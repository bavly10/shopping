import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/modules/Customer/customer_home_screen.dart';
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

  onBoardingItem(
      {Key? key,
      required this.splashModel,
      required this.index,
      required this.lisIndex,
      required this.lable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.50,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: splashModel,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) =>  const Icon(Icons.downloading),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
