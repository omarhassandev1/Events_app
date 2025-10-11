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
    focusColor: AppColors.lightBg,
    cardColor: AppColors.mainColor,
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 20,
      backgroundColor: AppColors.mainColor,
      selectedItemColor: AppColors.lightBg,
      unselectedItemColor: AppColors.lightBg,
      showSelectedLabels: false,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: TextStyle(
        color: AppColors.lightBg,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),

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
    focusColor: AppColors.mainColor,
    cardColor: AppColors.lightBg,
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
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 20,
      backgroundColor: AppColors.darkBg,
      selectedItemColor: AppColors.lightBg,
      unselectedItemColor: AppColors.lightBg,
      showSelectedLabels: false,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: TextStyle(
        color: AppColors.lightBg,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
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
