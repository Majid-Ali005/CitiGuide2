import 'package:flutter/material.dart';

class Constants {
  static Color greyColor = const Color(0xffE7E7E7);
  static String dashboardProfileImg = 'assets/images/profile.png';
  static String profileName = 'Hello Alex';
  static Color greyTextColor = const Color(0xffB6B6B6);
  static double buttonBorderRadius = 10;
  static double searchBarButtonHeight = 15;
  static LinearGradient orangeGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        Color(0xFADA5EFF),
        Color(0xFADA5EFF),
        Color(0xFADA5EFF),
      ]);
  static Color OrangeColor = const Color(0xFADA5EFF);

  static Color whiteColor = const Color.fromARGB(255, 255, 255, 255);
  static Color lightBlueColor = const Color.fromARGB(255, 255, 255, 255);
  static Color splashScreenPageColor = const Color(0xffD6D4A7);
  static String appLogo = 'assets/images/citiGuideIcon.png';
}
