import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/widgets.dart';

class BoxTitle extends StatelessWidget {
  final String title;
  final Color? color;
  final Gradient? gradient;
  const BoxTitle({
    super.key,
    required this.title,
    this.gradient,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (color != null) {
      return AppText(
        text: title,
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );
    }
    return GradientText(
      text: title,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      gradient: gradient!,
    );
  }
}
