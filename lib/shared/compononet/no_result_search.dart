import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class NoResultSearch extends StatelessWidget {
  const NoResultSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 150,
      ),
      child: Center(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width * .3,
            child: const Image(
              image: AssetImage('assets/no.png'),
            ),
          ),
          Text(
            mytranslate(context, "result"),
            style: TextStyle(
                color: myBlack, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ]),
      ),
    );
  }
}
