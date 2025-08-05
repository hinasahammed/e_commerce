import 'package:e_commerce/res/components/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.lightPrimaryColor,
      primary: AppColors.lightPrimaryColor,
      secondary: AppColors.secondaryColor,
      tertiary: AppColors.tertiaryColor,
      surface: AppColors.lightBackgroundColor,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(titleLarge: TextStyle(color: AppColors.textColor)),
    cardTheme: CardThemeData(color: AppColors.cardColor),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkPrimaryColor,
      primary: AppColors.darkPrimaryColor,
      secondary: AppColors.darkSecondaryColor,
      tertiary: AppColors.darkTertiaryColor,
      surface: AppColors.darkBackgroundColor,
      brightness: Brightness.dark,
    ),
    textTheme: TextTheme(titleLarge: TextStyle(color: AppColors.darkTextColor)),
    cardTheme: CardThemeData(color: AppColors.darkCardColor),
  );
}
