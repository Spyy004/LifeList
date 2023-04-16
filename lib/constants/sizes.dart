import 'package:flutter/material.dart';

class Sizes {
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double statusBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top;
  static double appBarHeight(BuildContext context) =>
      AppBar().preferredSize.height;
  static double bottomNavigationBarHeight(BuildContext context) =>
      kBottomNavigationBarHeight;

  // your custom sizes
  static double paddingSizeSmall = 8.0;
  static double paddingSizeMedium = 16.0;
  static double paddingSizeLarge = 32.0;
}
