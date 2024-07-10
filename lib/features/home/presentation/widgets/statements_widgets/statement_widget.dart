import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';

class StatementWidget extends StatelessWidget {
  final Statement statement;
  const StatementWidget({super.key, required this.statement});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppText(
            text: statement.text,
            fontSize: 16,
          ),
          const SizedBox(height: 4),
          if (statement.translation.isNotEmpty)
            AppText(
              text: statement.translation,
              textDirection: TextDirection.rtl,
              fontSize: 16,
              color: AppColors.yellow,
            ),
        ],
      ),
    );
  }
}
