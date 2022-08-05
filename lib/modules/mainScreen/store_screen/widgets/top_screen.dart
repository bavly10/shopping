import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../shared/my_colors.dart';

class TopScreen extends StatelessWidget {
  String? title, adress, image;

  TopScreen({Key? key, this.title, this.adress, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(backgroundImage: NetworkImage(image!), radius: 50),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(title!,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold)),
              RatingBar.builder(
                itemSize: 15,
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: myBlue,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: HexColor("#2F69F8"),
                      size: 15,
                    ),
                    Text(
                      adress!,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
