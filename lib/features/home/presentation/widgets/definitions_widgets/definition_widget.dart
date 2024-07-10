import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/string_utils.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';

class DefinitionWidget extends StatelessWidget {
  final String definition;
  const DefinitionWidget({
    super.key,
    required this.definition,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: AppText(
        text: '- ${StringUtils.capitalize(definition)}',
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
