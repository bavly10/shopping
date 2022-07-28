import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopping/model/product_info.dart';
import 'package:shopping/model/show_product_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../shared/my_colors.dart';

class CustomImageContainer extends StatelessWidget {
  List<ImageInfoPro> image;
  CustomImageContainer({
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    var controller = PageController();
    return Column(
      children: [
        Container(
            height: 250,
            width: 260,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: PageView.builder(
              controller: controller,
              itemCount: image.length,
              itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(image[index].logo!)))),
            )),
        SmoothPageIndicator(
          effect: ScrollingDotsEffect(
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: myBlue,
            spacing: 20,
            dotColor: myBlack,
          ),
          controller: controller,
          count: image.length,
        ),
      ],
    );
  }
}
