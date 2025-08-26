import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimersTheme {


  static const CupertinoTextThemeData _textTheme = CupertinoTextThemeData(

    navLargeTitleTextStyle: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    navTitleTextStyle: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );

  static const Color actionButtonsBackgroundColor = Color.fromARGB(255, 6, 23, 10);

  static const Color _primaryColor = CupertinoColors.systemOrange;

  static CupertinoThemeData get light {
    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: _primaryColor,
      textTheme: _textTheme,
    );
  }

  static CupertinoThemeData get dark {
    return CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: _primaryColor,
      textTheme: _textTheme,
    );
  }
}