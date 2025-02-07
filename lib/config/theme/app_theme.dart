import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'SFPro',
  appBarTheme: appBarTheme,
);

AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: Colors.white,
  elevation: 0,
  centerTitle: true,
  iconTheme: IconThemeData(color: Color(0xFF8B8B8B)),
  titleTextStyle: TextStyle(
    color: Color(0xFF8B8B8B),
    fontSize: 18,
  ),
);
