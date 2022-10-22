import 'package:flutter/material.dart';
import 'package:shopping/shared/compononet/arrowBack.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/localization/translate.dart';

class EmptyFav extends StatelessWidget {
  const EmptyFav({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          const Image(width: double.infinity,image: ExactAssetImage("assets/empty.png")),
          const SizedBox(height: 25,),
          Text(mytranslate(context, "emptyFav"),style: textStyle1,),
        ],
      ),
    );
  }
}
