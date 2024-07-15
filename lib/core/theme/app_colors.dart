import 'dart:math' show Random;

import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const scaffoldBackgroundColor = Color(0xff141419);
  static const grey = Color(0xFF272930);
  static const blue = Color(0xFF47A3FF);
  static const yellow = Color(0xFFFFD36F);
  static const green = Color(0xFF79C47E);
  static const pink = Color(0xFFFFA6C9);
  static const purple = Color(0xFF7B64DF);
  static const white = Colors.white;

  static const List<Color> _colors = [
    blue,
    yellow,
    green,
    pink,
    purple,
    Colors.teal,
    Colors.redAccent,
    Colors.brown,
    Colors.blueGrey,
    Colors.white,
    Colors.cyan,
    Colors.lime,
    Colors.indigo,
  ];

  static Color? prevColor;

  static final _random = Random();

  static Color get randomColor {
    Color color = _colors[_random.nextInt(_colors.length)];
    while (prevColor == color) {
      color = _colors[_random.nextInt(_colors.length)];
    }
    prevColor = color;
    return color;
  }
}
