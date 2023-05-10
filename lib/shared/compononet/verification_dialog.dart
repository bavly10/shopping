import 'package:flutter/material.dart';

import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';

class CustomDialog extends StatelessWidget {
  void Function()? onTap;
  String? text;
  String? btnName;
  CustomDialog({Key? key, this.onTap, this.text, this.btnName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 250,
            padding: const EdgeInsets.only(
              top: 18.0,
            ),
            margin: const EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(text!,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600)),
                ) //
                    ),
                const SizedBox(height: 24.0),
                InkWell(
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: myBlue,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                            bottomLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0)),
                      ),
                      child: Text(
                        btnName ?? mytranslate(context, "verify"),
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: onTap)
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: myBlue,
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
