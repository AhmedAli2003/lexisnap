import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/pages/view_word_page.dart';
import 'package:lexisnap/features/home/presentation/widgets/speak_icon.dart';

class WordTileWidget extends StatelessWidget {
  final Word word;
  final WidgetRef ref;
  const WordTileWidget({
    super.key,
    required this.word,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = getSubtitile(word);
    return ListTile(
      onTap: () => onTap(context),
      leading: Container(
        width: 4,
        decoration: BoxDecoration(
          color: AppColors.randomColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      title: Row(
        children: [
          Text(
            word.word,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          if (word.translations.isNotEmpty) const Spacer(),
          if (word.translations.isNotEmpty)
            Text(
              word.translations.first,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: AppColors.purple,
                fontSize: 18,
              ),
            ),
        ],
      ),
      subtitle: Text(
        subtitle ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: SpeakIcon(text: word.word),
    );
  }

  void onTap(BuildContext context) {
    ref.read(wordProvider.notifier).updateWordObject(word);
    GoRouter.of(context).pushNamed(ViewWordPage.name);
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
