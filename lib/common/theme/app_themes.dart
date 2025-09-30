import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBg,
    dividerTheme: DividerThemeData(
      color: AppColors.mainColor,
      endIndent: 16,
      indent: 16,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.mainColor,
      primary: AppColors.mainColor,
    ),
    hintColor: AppColors.grayColor,
    hoverColor: AppColors.grayColor,
    appBarTheme: AppBarTheme(
      color: AppColors.lightBg,
      iconTheme: IconThemeData(color: AppColors.mainColor),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.mainColor,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: _getTextTheme(AppColors.textColorLight),
  );

  static ThemeData dartTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBg,
    dividerTheme: DividerThemeData(
      color: AppColors.mainColor,
      endIndent: 16,
      indent: 16,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.mainColor,
      primary: AppColors.mainColor,
    ),
    hintColor: AppColors.mainColor,
    hoverColor: AppColors.textColorDark,
    appBarTheme: AppBarTheme(
      color: AppColors.darkBg,
      iconTheme: IconThemeData(color: AppColors.mainColor),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.mainColor,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: _getTextTheme(AppColors.textColorDark),
  );

  static TextTheme _getTextTheme(Color textColor) {
    return TextTheme(
      labelSmall: TextStyle(
        color: textColor,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: textColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        color: textColor,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
