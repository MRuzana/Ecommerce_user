import 'package:clothing/config/themes/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';


class AppTheme{

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    brightness: Brightness.light,
    primaryColor: const Color(0xFFF84545),
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.lightTextTheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white, 
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
    ),
  ); 

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFF84545),
    scaffoldBackgroundColor: Colors.black,
    textTheme: AppTextTheme.darkTextTheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
    ),
  ); 
}