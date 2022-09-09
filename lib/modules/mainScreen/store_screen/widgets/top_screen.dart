import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopping/shared/compononet/custom_rating.dart';
import 'package:shopping/shared/my_colors.dart';

import '../../../../shared/compononet/popup_dialog.dart';

class TopScreen extends StatelessWidget {
  String? adress, image, rate;
  Color? star, textColor, locationColor;
  final String title;

  TopScreen(
      {Key? key,
      required this.title,
      this.adress,
      this.image,
      this.star,
      this.locationColor,
      this.textColor,
      this.rate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => PopupDialog(
                        image: image,
                      ));
            },
            child: CircleAvatar(
                backgroundImage: NetworkImage(image!), radius: 50)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(title,
                  style: TextStyle(
                      color: textColor ?? Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              CustomRating(
                rate: rate,
                star: star,
              ),
              // RatingBarIndicator(
              //   rating: double.parse(rate!),
              //   itemBuilder: (context, index) => Icon(
              //     Icons.star,
              //     color: star ?? myBlue,
              //   ),
              //   itemCount: 5,
              //   itemSize: 15,
              //   direction: Axis.horizontal,
              //   itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              // ),
              // RatingBar.builder(
              //   itemSize: 15,
              //   initialRating: double.parse(rate!),
              //   minRating: 0,
              //   direction: Axis.horizontal,
              //   allowHalfRating: true,
              //   itemCount: 5,
              //   itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              //   itemBuilder: (context, _) => Icon(
              //     Icons.star,
              //     color: star ?? myBlue,
              //   ),
              //   onRatingUpdate: (rating) {

              //     // print(rating);
              //   },
              // ),
              adress == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: locationColor ?? HexColor("#2F69F8"),
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

  showAlertDialog(BuildContext context, image, title) {
    AlertDialog alert = AlertDialog(
      titlePadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(
              color: myBlue, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(35.0)),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
