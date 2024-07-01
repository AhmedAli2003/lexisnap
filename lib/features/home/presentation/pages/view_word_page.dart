import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/speak_icon.dart';
import 'package:lexisnap/features/home/presentation/widgets/tags_card.dart';
import 'package:lexisnap/features/home/presentation/widgets/translations_widgets/translation_widget.dart';

class ViewWordPage extends ConsumerWidget {
  static const String path = 'view-word';
  static const String name = 'View-Word-Page';

  const ViewWordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final word = ref.watch(wordProvider);
    return Scaffold(
      body: SafeArea(
        child: word == null
            ? const Loading()
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.menu_book_rounded,
                            size: 32,
                          ),
                          const SizedBox(width: 8),
                          SelectableText(
                            word.word,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          SpeakIcon(text: word.word),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Translations',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blue,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          children: [
                            for (final translation in word.translations)
                              TranslationWidget(
                                translation: translation,
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Definitions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blue,
                        ),
                      ),
                      for (final definition in word.definitions)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SelectableText(
                            '- $definition',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      const SizedBox(height: 20),
                      const Text(
                        'Example Sentences',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blue,
                        ),
                      ),
                      for (final statement in word.statements)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //TODO: Speak
                                },
                                child: SelectableText(
                                  '- ${statement.text}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SelectableText(
                                  statement.translation,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: AppColors.yellow,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      const SizedBox(height: 20),
                      const Text(
                        'Tags',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blue,
                        ),
                      ),
                      Wrap(
                        children: [
                          for (final tag in word.tags) TagCard(tag: tag),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
