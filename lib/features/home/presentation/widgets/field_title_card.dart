import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';

class FieldTitleCard extends StatelessWidget {
  final String title;
  const FieldTitleCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.blue,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 12.0,
        ),
        child: AppText(text: title),
      ),
    );
  }
}
