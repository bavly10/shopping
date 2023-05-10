import 'package:flutter/material.dart';
import 'package:myshoop/shared/localization/translate.dart';
import 'package:myshoop/shared/my_colors.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      elevation: 0.0,
      content: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(mytranslate(context, "loading"),style: TextStyle(color: Colors.black),),
          const SizedBox(height: 10,),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
