import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle poppins({
  double fontSize = 16,
  Color? color,
  FontWeight? fontWeight,
  double? wordSpacing,
  double? letterSpacing,
}) {
  return GoogleFonts.poppins(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    wordSpacing: wordSpacing,
    letterSpacing: letterSpacing,
  );
}
