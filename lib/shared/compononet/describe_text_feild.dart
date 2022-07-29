import 'package:flutter/material.dart';

import 'package:shopping/shared/my_colors.dart';

class MyDescribeTextField extends StatelessWidget {
  late TextEditingController controller;
  TextInputType? type;
  String? Function(String?)? validate;
  late String label;

  void Function()? suffixPressed;
  int? maxline;
  MyDescribeTextField(
      {Key? key,
      required this.controller,
      this.type,
      this.validate,
      required this.label,
      this.maxline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .08,
      child: TextFormField(
        maxLines: maxline,
        keyboardType: type,
        onChanged: (value) {},
        onTap: () {},
        validator: (value) {},
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(40.0),
              ),
              borderSide: BorderSide(color: myGrey!, width: 1),
            ),
            hintText: label,
            hintStyle: TextStyle(color: Colors.black.withOpacity(.6))),
      ),
    );
  }
}
