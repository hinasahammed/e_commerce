import 'package:e_commerce/res/components/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightScaffoldBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.lightPrimaryColor,
      primary: AppColors.lightPrimaryColor,
      secondary: AppColors.secondaryColor,
      tertiary: AppColors.tertiaryColor,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.textColor),
    ),
    cardTheme: const CardThemeData(color: AppColors.cardColor),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkScaffoldBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkPrimaryColor,
      // primary: AppColors.darkPrimaryColor,
      // onPrimary: AppColors.darkTextColor,
      secondary: AppColors.darkSecondaryColor,
      tertiary: AppColors.darkTertiaryColor,
      brightness: Brightness.dark,
    ),
    // textTheme: const TextTheme(
    //   titleLarge: TextStyle(color: AppColors.darkTextColor),
    // ),
    // cardTheme: const CardThemeData(color: AppColors.darkCardColor),
  );
}
