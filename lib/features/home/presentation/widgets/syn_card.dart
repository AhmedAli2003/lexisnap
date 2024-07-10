import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';

class SynCard extends StatelessWidget {
  final MinimalWord word;

  const SynCard({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.green,
            Color.fromRGBO(121, 196, 126, 0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: AppText(
        text: word.word,
        fontSize: 14,
        color: AppColors.scaffoldBackgroundColor,
      ),
    );
  }
}
