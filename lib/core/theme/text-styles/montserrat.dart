import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle montserrat({
  double fontSize = 16,
  Color? color,
  FontWeight? fontWeight,
  double? wordSpacing,
  double? letterSpacing,
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    letterSpacing: letterSpacing,
  );
}
