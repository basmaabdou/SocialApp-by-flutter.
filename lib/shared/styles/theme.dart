
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'color.dart';

ThemeData darkTheme=ThemeData(
    primarySwatch:defaultColor,
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        backgroundColor: HexColor('333739'),
        elevation: 0,
        titleTextStyle: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('333739'),
            statusBarIconBrightness: Brightness.light
        ),
        iconTheme: IconThemeData(
            color: Colors.white,
            size: 30
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 30.0,
      backgroundColor: HexColor('333739'),
    ),
    scaffoldBackgroundColor: HexColor('333739'),

    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white
        ),
        bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 12
        ),
        subtitle1: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 14,
            color: Colors.black,
            height: 1.3
        )
    ),
    fontFamily: 'Jannah'

);

ThemeData lightTheme=ThemeData(
    primarySwatch:defaultColor ,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        color: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
            fontFamily: 'Jannah',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
        iconTheme: IconThemeData(
            color: Colors.black54,
            size: 30
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 30.0,
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black
        ),
        bodyText2: TextStyle(
            color: Colors.black
        ),
      subtitle1: TextStyle(
          fontWeight: FontWeight.w200,
          fontSize: 14,
          color: Colors.black,
        height: 1.3
      )
    ),
    fontFamily: 'Jannah'
);