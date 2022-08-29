import 'package:flutter/material.dart';
import 'package:shopping/shared/localization/translate.dart';
import 'package:shopping/shared/my_colors.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent.withOpacity(.05),
      content: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.996,
      child: Column(
        children: [
          Text(mytranslate(context, "loading")),
          const SizedBox(height: 10,),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
