import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shopping/shared/my_colors.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/90.jpg"))),
            ),
          ),
          Text(
            "Something Is Error!\n        Try Again",
            style: TextStyle(
                color: myBlue, fontSize: 25, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
