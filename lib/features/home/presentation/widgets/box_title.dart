import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';

class BoxTitle extends StatelessWidget {
  final String title;
  final Color? color;
  const BoxTitle({
    super.key,
    required this.title,
    this.color = AppColors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: title,
      color: color,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
  }
}
