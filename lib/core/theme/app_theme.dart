import 'package:flutter/material.dart';
import 'package:lexisnap/core/theme/app_colors.dart';

class AppTheme {
  const AppTheme._();
  static ThemeData get light => _lightTheme;
  static final _lightTheme = ThemeData.light(useMaterial3: true).copyWith();

  static ThemeData get dark => _datkTheme;
  static final _datkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.grey,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      elevation: 0.0,
    ),
    cardColor: AppColors.grey,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.blue,
    ),
  );
}
