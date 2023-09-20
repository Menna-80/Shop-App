import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData darktheme = ThemeData(
  // primaryColor: Colors.deepOrange,
  primarySwatch: defaultcolor,
  appBarTheme: AppBarTheme(
    titleSpacing: 16.0,
    backgroundColor: Colors.grey[800],
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey[800],
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.grey[200],
      size: 30.0,
    ),
  ),
  scaffoldBackgroundColor: Colors.grey[800],
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    elevation: 20.0,
    backgroundColor: Colors.grey[800],
    unselectedItemColor: Colors.grey[200],
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
    ),
  ),
  fontFamily: 'fonts',
);
ThemeData lighttheme = ThemeData(
  // primaryColor: Colors.deepOrange,
  primarySwatch: defaultcolor,
  appBarTheme: AppBarTheme(
    titleSpacing: 16.0,
    backgroundColor: Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 30.0,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      elevation: 20.0,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black),
  fontFamily: 'fonts',
);
