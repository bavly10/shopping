import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:shopping/modules/cart/cart.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class SuccessOrder extends StatelessWidget {
  final String phone;
  const SuccessOrder({Key? key, required this.phone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            HexColor(
              '#09C6F9',
            ),
            HexColor('#045DE9')
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 200, right: 12, left: 12),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                  child: Icon(
                    Icons.done,
                    color: myBlue,
                    size: 66,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                  child: Text(mytranslate(context, "excd"),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(mytranslate(context, "prog"),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.phone_android,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      phone,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(mytranslate(context, "before"),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(27.0),
                  child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width * .5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        navigateTo(context, CartScreen());
                      },
                      textColor: myBlue,
                      color: Colors.white,
                      child: Text(
                        mytranslate(context, "ok"),
                        style: TextStyle(
                            color: myBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
