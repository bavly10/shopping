import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../my_colors.dart';

class CustomRating extends StatelessWidget {
  Color? star;
  String? rate;
  CustomRating({Key? key, this.star, this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: double.parse(rate!),
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: star ?? myBlue,
      ),
      itemCount: 5,
      itemSize: 15,
      direction: Axis.horizontal,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
    );
  }
}
