import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/presentation/controllers/selected_translations_provider.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/translations_widgets/translation_widget.dart';
import 'package:lexisnap/features/home/presentation/widgets/translations_widgets/remove_translation_icon_button.dart';

class TranslationsWrapWidget extends ConsumerWidget {
  const TranslationsWrapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(wordTranslationsProvider);
    final selectedTranslations = ref.watch(selectedTranslationsProvider);
    return Align(
      alignment: Alignment.centerRight,
      child: Wrap(
        children: getChildren(ref, translations, selectedTranslations),
      ),
    );
  }

  List<Widget> getChildren(WidgetRef ref, Set<String> translations, SelectedTranslationsState selectedTranslations) {
    final children = translations.map<Widget>((t) => TranslationWidget(translation: t)).toList();
    if (selectedTranslations.isNotEmpty) {
      children.add(
        RemoveTranslationsIconButton(
          onTap: () => delete(ref, selectedTranslations.translations),
        ),
      );
    }
    return children.reversed.toList();
  }

  void delete(WidgetRef ref, Set<String> selectedTransactions) {
    ref.read(wordProvider.notifier).removeManyTranslations(selectedTransactions);
    ref.read(selectedTranslationsProvider.notifier).clear();
  }
}
