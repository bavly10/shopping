import 'package:flutter/material.dart';
import 'package:shopping/shared/localization/set_localization.dart';

String mytranslate(BuildContext context,key){
  return SetLocalztion.of(context).getTranslatevalue(key);
}