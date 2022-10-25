import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData dark = ThemeData(
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Colors.black26,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black26,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.black26,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        iconTheme: IconThemeData(
            color: Colors.white
        )

    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black26,
        elevation: 10,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white
    ),
    textTheme:const TextTheme(
      bodyText1: TextStyle(
          fontSize: 16,
          color: Colors.grey
      ),
    ),
    inputDecorationTheme:const InputDecorationTheme(
        fillColor: Colors.white
    )
);

ThemeData light = ThemeData(
  primarySwatch: Colors.pink,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    iconTheme: IconThemeData(
        color: Colors.black
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 10,
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.black
  ),
  textTheme:const TextTheme(
    bodyText1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black
    ),
  ),
);