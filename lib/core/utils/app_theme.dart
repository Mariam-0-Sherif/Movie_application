import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.blackColor,

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.blackColor,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.transparentColor,
      centerTitle: true,
    ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.transparentColor
      )
  );
}
