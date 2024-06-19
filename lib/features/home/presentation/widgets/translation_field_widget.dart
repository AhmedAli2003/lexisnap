import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/custom_text_field.dart';
import 'package:lexisnap/features/home/presentation/widgets/field_title_card.dart';
import 'package:lexisnap/features/home/presentation/widgets/translation_widget.dart';

final selectedTranslationsProvider = StateProvider.autoDispose<List<String>>((ref) => []);

class TranslationFieldWidget extends ConsumerStatefulWidget {
  const TranslationFieldWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TranslationFieldWidgetState();
}

class _TranslationFieldWidgetState extends ConsumerState<TranslationFieldWidget> {
  late final TextEditingController controller;
  late final FocusNode node;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    node = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final word = ref.watch(wordProvider)!;
    return Column(
      children: [
        Row(
          children: [
            const FieldTitleCard(title: 'Translations'),
            IconButton(
              onPressed: () {
                node.requestFocus();
              },
              icon: const Icon(Icons.add_rounded),
            ),
            Expanded(
              child: CustomTextField(
                textDirection: TextDirection.rtl,
                controller: controller,
                focusNode: node,
                hint: word.translations.isEmpty ? 'Write a word translation' : null,
                hintStyle: HintStyle.small,
                onEditingComplete: () {
                  node.unfocus();
                  final text = controller.text.trim();
                  if (text.isNotEmpty) {
                    ref.read(wordProvider.notifier).addTranslation(text);
                    controller.clear();
                  }
                },
              ),
            ),
          ],
        ),
        if (word.translations.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              direction: Axis.horizontal,
              textDirection: TextDirection.rtl,
              children: [
                for (final translation in word.translations)
                  TranslationWidget(
                    translation: translation,
                    onTap: () {
                      ref.read(selectedTranslationsProvider.notifier).update((state) {
                        List<String> selected = [...state];
                        if (selected.contains(translation)) {
                          selected.remove(translation);
                        } else {
                          selected.add(translation);
                        }
                        return selected;
                      });
                    },
                  ),

                //After the loop and inside the Wrap
                if (ref.watch(selectedTranslationsProvider).isNotEmpty)
                  IconButton(
                    onPressed: () {
                      final translationsToDelete = ref.read(selectedTranslationsProvider);
                      ref.read(wordProvider.notifier).deleteManyTranslations(translationsToDelete);
                      ref.read(selectedTranslationsProvider.notifier).update((state) => []);
                    },
                    icon: const Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
