import 'package:flutter/material.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';

class CustomListTile extends StatelessWidget {
  String textTitle;
  IconData trailingIcon;
  void Function()? onTap;
  CustomListTile(
      {Key? key,
        required this.textTitle,
        required this.trailingIcon,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        mytranslate(context, textTitle),
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700]),
      ),
      trailing: Icon(
        trailingIcon,
        size: 22,
        color: myBlue,
      ),
      onTap: onTap,
    );
  }
}
