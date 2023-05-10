import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:myshoop/shared/localization/translate.dart';

class PaymentError extends StatelessWidget {
  final dynamic mytext;
  const PaymentError({Key? key,this.mytext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#eff1f3'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/15_Payment Error.png",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.50,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              mytext,
              style: const TextStyle(fontSize: 18.0, color: Colors.blueGrey),
              textAlign: TextAlign.center,
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 13),
                    blurRadius: 25,
                    color: Color(0xFF5666C2).withOpacity(0.17),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // navigateToFinish(context, Introducer(cubit.id!));
                },
                child: Text(
                  mytranslate(context, "back"),
                  style: const TextStyle(color: Colors.white),
                ), 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
