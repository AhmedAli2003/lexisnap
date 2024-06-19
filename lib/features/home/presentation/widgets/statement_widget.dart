import 'package:flutter/material.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';
import 'package:lexisnap/features/home/presentation/widgets/speak_icon.dart';

class StatementWidget extends StatelessWidget {
  final Statement statement;
  const StatementWidget({super.key, required this.statement});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  statement.text,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  statement.translation,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.yellow,
                  ),
                ),
              ],
            ),
          ),
        ),
        SpeakIcon(
          text: statement.text,
          size: 24,
        ),
      ],
    );
  }
}
