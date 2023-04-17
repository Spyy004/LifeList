import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.lightBlue,
    secondaryHeaderColor: Colors.lightGreen,
    dividerColor: Colors.grey,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      displayMedium: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      displaySmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
        fontFamily: 'Roboto',
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      bodyMedium: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      bodySmall: TextStyle(
        fontSize: 8.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      labelLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    secondaryHeaderColor: Colors.purple,
    hintColor: Colors.teal,
    iconTheme: const IconThemeData(color: Colors.white),
    dividerColor: Colors.grey,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      displayMedium: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      displaySmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
        fontFamily: 'Roboto',
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      bodyMedium: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      bodySmall: TextStyle(
        fontSize: 8.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      labelLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
    ),
  );

  static ThemeData systemTheme(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark ? darkTheme : lightTheme;
  }
}
