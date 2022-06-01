import 'package:shopping/Cubit/cubit.dart';
import 'package:shopping/modules/Splash_screen/animation_Splash/animation_screen.dart';
import 'package:shopping/modules/Splash_screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:shopping/shared/my_colors.dart';

class Animation_Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(
            children: <Widget>[
              SplashScreen(),
              IgnorePointer(
                  child: AnimationScreen(color: Colors.red)
              )
            ]
        )
    );
  }
}



