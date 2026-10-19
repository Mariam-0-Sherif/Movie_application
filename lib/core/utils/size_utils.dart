import 'package:flutter/material.dart';

class SizeUtils {
  static double widthScreen = 430;
  static double heightScreen = 932;

  static double getWidth(BuildContext context, double width) {
    double widthNeed = width / widthScreen;
    return MediaQuery.of(context).size.width * widthNeed;
  }

  static double getHeight(BuildContext context, double height) {
    double heightNeed = height / widthScreen;
    return MediaQuery.of(context).size.width * heightNeed;
  }
}
