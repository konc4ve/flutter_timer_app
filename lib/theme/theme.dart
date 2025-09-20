import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimersTheme {
  static const CupertinoTextThemeData _textTheme = CupertinoTextThemeData(
    dateTimePickerTextStyle: TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      color: Color.fromARGB(255, 134, 134, 134),
    ),
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
    actionTextStyle: TextStyle(color: CupertinoColors.white, fontSize: 22),
    ///Мидл тайтл
    actionSmallTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 17,
    ),
  );

  static const Color actionButtonsBackgroundColor = Color.fromARGB(
    255,
    6,
    23,
    10,
  );

  static const Divider tileDivider = Divider(
    color: Color.fromARGB(255, 16, 16, 16),
    height: 0,
    thickness: 0.5,
  );

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
