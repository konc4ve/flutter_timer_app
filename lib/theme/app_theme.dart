import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      // Кастомизируем тёмную тему:
      colorScheme: ColorScheme.dark(
        primary: Colors.amber,
        secondary: Colors.tealAccent[200]!,
        surface: const Color(0xFF121212),
      ),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.tealAccent[200],
      ),
    );
  }
}