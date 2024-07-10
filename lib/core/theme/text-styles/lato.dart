import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle lato({
  double fontSize = 16,
  Color? color,
  FontWeight? fontWeight,
  double? wordSpacing,
  double? letterSpacing,
}) {
  return GoogleFonts.lato(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    letterSpacing: letterSpacing,
  );
}
