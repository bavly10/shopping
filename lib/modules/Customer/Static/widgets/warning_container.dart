import 'package:flutter/material.dart';
import 'package:myshoop/shared/compononet/componotents.dart';
import 'package:myshoop/shared/localization/translate.dart';

import '../../../../shared/my_colors.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myGrey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            color: myBlack,
          ),
         const SizedBox(width: 3),
          Expanded(
            child: Text(
              mytranslate(context, "static"),
              style: textStyle3,
            ),
          ),
        ],
      ),
    );
  }
}
