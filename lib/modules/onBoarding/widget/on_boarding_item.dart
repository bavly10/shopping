import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping/shared/compononet/MyCachedNetworkImage.dart';

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
      child:MyCachedNetWorkImage(logo: splashModel,radius:25.0,)
    );
  }
}
