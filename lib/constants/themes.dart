import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: const MaterialColor(
      0xFFFFFFFF,
      <int, Color>{
        50: Color(0xffefdbff),
        100: Color(0xffefdbff),
        200: Color(0xffefdbff),
        300: Color(0xffefdbff),
        400: Color(0xffefdbff),
        500: Color(0xffefdbff),
        600: Color(0xffefdbff),
        700: Color(0xffefdbff),
        800: Color(0xFFFFFFFF),
        900: Color(0xFFFFFFFF),
      },
    ),
    secondaryHeaderColor: const Color(0xffcf89f8),
    dividerColor: Colors.grey,
    fontFamily: 'Myfont',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Myfont',
      ),
      displayMedium: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Myfont',
      ),
      displaySmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Myfont',
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontFamily: 'Myfont',
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontFamily: 'Myfont',
      ),
      bodyMedium: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontFamily: 'Myfont',
      ),
      bodySmall: TextStyle(
        fontSize: 8.0,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontFamily: 'Myfont',
      ),
      labelLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Myfont',
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    secondaryHeaderColor: Colors.purple,
    hintColor: Colors.teal,
    iconTheme: const IconThemeData(color: Colors.white),
    dividerColor: Colors.grey,
    fontFamily: 'Myfont',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Myfont',
      ),
      displayMedium: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Myfont',
      ),
      displaySmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Myfont',
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
        fontFamily: 'Myfont',
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontFamily: 'Myfont',
      ),
      bodyMedium: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontFamily: 'Myfont',
      ),
      bodySmall: TextStyle(
        fontSize: 8.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontFamily: 'Myfont',
      ),
      labelLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Myfont',
      ),
    ),
  );

  static ThemeData systemTheme(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark ? darkTheme : lightTheme;
  }
}
