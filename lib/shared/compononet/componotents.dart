import 'package:flutter/material.dart';

 navigateTo(context, widget) => Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateToFinish(context, widget) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));