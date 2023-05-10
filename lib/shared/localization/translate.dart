import 'package:flutter/material.dart';
import 'package:myshoop/shared/localization/set_localization.dart';

String mytranslate(BuildContext context,key){
  return SetLocalztion.of(context).getTranslatevalue(key);
}