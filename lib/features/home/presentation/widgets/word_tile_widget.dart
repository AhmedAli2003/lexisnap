import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';
import 'package:lexisnap/features/home/presentation/widgets/speak_icon.dart';

class WordTileWidget extends StatelessWidget {
  final Word word;
  final void Function() onTap;
  const WordTileWidget({
    super.key,
    required this.word,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = getSubtitile(word);
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 4,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.gradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      title: Row(
        children: [
          AppText(
            text: word.word,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
          if (word.translations.isNotEmpty) const Spacer(),
          if (word.translations.isNotEmpty)
            GradientText(
              text: word.translations.first,
              fontWeight: FontWeight.normal,
              gradient: const LinearGradient(
                colors: [
                  Colors.deepPurple,
                  Color.fromARGB(255, 185, 164, 241),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              fontSize: 18,
            ),
        ],
      ),
      subtitle: AppText(
        text: subtitle ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: SpeakIcon(
        text: word.word,
        id: word.id,
      ),
      contentPadding: const EdgeInsets.only(right: 8, left: 16),
    );
  }

  String? getSubtitile(Word word) {
    if (word.statements.isNotEmpty) {
      return word.statements.first.text;
    }
    if (word.definitions.isNotEmpty) {
      return word.definitions.first;
    }
    if (word.tags.isNotEmpty) {
      return word.tags.first.name;
    }
    if (word.synonyms.isNotEmpty) {
      return word.synonyms.first.word;
    }
    if (word.opposites.isNotEmpty) {
      return word.opposites.first.word;
    }
    return null;
  }
}
