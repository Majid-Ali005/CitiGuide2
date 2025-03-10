import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:citi_guide/screens/SplashScreens/fiveSplashScreen.dart';
import 'package:flutter/material.dart';


class SecondSplashScreen extends StatelessWidget {
  const SecondSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/secondSplashScreenVector.png',
      nextScreen: const FifthSplashScreen(),
      splashTransition: SplashTransition.scaleTransition,
      duration: 100,
         );
  }
}