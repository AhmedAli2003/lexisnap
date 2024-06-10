import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();
  static ThemeData get light => _lightTheme;
  static final _lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
    ),
  );
}
