import 'package:flutter/material.dart';
import 'package:myshoop/shared/my_colors.dart';

class PopupDialog extends StatelessWidget {
  String? image;
  PopupDialog({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent.withOpacity(.03),
      content: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.996,
      //  margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              image!,
            ),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(35.0)),
    );
  }
}
