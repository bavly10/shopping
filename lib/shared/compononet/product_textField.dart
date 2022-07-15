import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping/shared/my_colors.dart';

class MyProTextField extends StatelessWidget {
  late TextEditingController controller;
  TextInputType? type;
  void Function(String)? onSubmit;
  void Function()? onTap;
  String? Function(String?)? validate;
  late bool obcure;
  void Function()? suffixPressed;

  MyProTextField({
    Key? key,
    required this.controller,
    this.type,
    required this.obcure,
    this.onSubmit,
    this.onTap,
    this.validate,

    this.suffixPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * .07,
        child: TextFormField(
          obscureText: obcure,
          keyboardType: type,
          onChanged: (value) {},
          onTap: () {},
          validator: (value) {},
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(45.0),
                ),
                borderSide: BorderSide(width: 1, color: myGrey!),
              ),
              hintStyle: TextStyle(color: HexColor('#000000').withOpacity(.6))),
        ));
  }
}
