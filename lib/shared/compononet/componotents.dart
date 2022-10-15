import 'package:flutter/material.dart';
import 'package:shopping/shared/my_colors.dart';

navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateToFinish(context, widget) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
var textStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
var textStyle1 =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: myBlue);
var textStyle2 = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueAccent[400]);
var textStyle3 = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 14, color: Colors.redAccent[700]);
