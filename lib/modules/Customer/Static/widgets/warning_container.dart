import 'package:flutter/material.dart';
import 'package:shopping/shared/compononet/componotents.dart';

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
          SizedBox(width: 3),
          Expanded(
            child: Text(
              "Press above any column to get additional information  ",
              style: textStyle3,
            ),
          ),
        ],
      ),
    );
  }
}
