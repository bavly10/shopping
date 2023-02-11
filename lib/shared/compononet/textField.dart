import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

import 'package:shopping/shared/my_colors.dart';

class MyTextField extends StatelessWidget {
  late TextEditingController controller;
  TextInputType? type;
  void Function(String)? onSubmit;
  void Function()? onTap;
  String? Function(String?)? validate;
  late String label;
  IconData? prefix;
  int? maxline=1;
  bool readonly=false;
  IconData? suffix;
  late bool obcure;
  void Function()? suffixPressed;
  MyTextField({
    Key? key,
    required this.controller,
    this.type,
    required this.obcure,
    this.onSubmit,
    this.onTap,
    this.validate,
    this.maxline,
    required this.label,
    this.prefix,
    required this.readonly,
    this.suffix,
    this.suffixPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: MediaQuery.of(context).size.height * .08,
      child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: HexColor('#0063FF').withOpacity(.2),
              blurRadius: 20,
              offset: const Offset(0, 0),
            )
          ]),
          child: TextFormField(
            scrollPadding: const EdgeInsets.all(8),
            obscureText: obcure,
            keyboardType: type,
            validator: validate,
            readOnly: readonly,
            maxLines: maxline,
            controller: controller,
            decoration: InputDecoration(
                suffix: InkWell(
                    onTap: suffixPressed,
                    child: Icon(
                      suffix,
                      size: 20,
                      color: myBlack,
                    )),
                fillColor: HexColor('#FFFFFF'),
                filled: true,
                prefixIcon: Icon(
                  prefix,
                  color: HexColor('#0065FC'),
                ),
                focusColor: HexColor('#0063FF'),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  borderSide: BorderSide.none,
                ),
                hintText: label,
                hintStyle: TextStyle(color: Colors.black.withOpacity(.6))),
          )),
    );
  }
}
