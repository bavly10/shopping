import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shopping/modules/onBoarding/onBoardingFirst.dart';
import 'package:shopping/shared/compononet/componotents.dart';
import 'package:shopping/shared/my_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(milliseconds:3500), () => { navigateToFinish(context, OnBoardingFirst(),)});
  }
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds:2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child:  Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
              height: MediaQuery.of(context).size.height * 0.20,
              width: double.infinity,
              image: const ExactAssetImage("assets/logo.png"),
            ),
          ),
        ),
      ),
    );
  }
}
