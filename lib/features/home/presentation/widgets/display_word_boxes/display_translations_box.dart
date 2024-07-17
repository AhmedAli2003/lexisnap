import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/translations_widgets/translation_widget.dart';
import 'package:lexisnap/features/home/presentation/widgets/translations_widgets/translations_title.dart';

class DisplayTranslationsBox extends ConsumerWidget {
  const DisplayTranslationsBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(wordTranslationsProvider);
    return translations.isEmpty
        ? const SizedBox()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const TranslationsTitle(),
              Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  children: translations
                      .map(
                        (t) => TranslationWidget(translation: t, fromView: true),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
  }
}
