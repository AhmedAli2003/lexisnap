import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/box_title.dart';
import 'package:lexisnap/features/home/presentation/widgets/translations_widgets/translation_widget.dart';

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
              const BoxTitle(
                title: 'Translations',
                color: AppColors.purple,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  children: translations
                      .map(
                        (t) => TranslationWidget(translation: t),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
  }
}
