import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/box_title.dart';
import 'package:lexisnap/features/home/presentation/widgets/custom_text_field.dart';
import 'package:lexisnap/features/home/presentation/widgets/translations_widgets/translations_wrap_widget.dart';

class TranslationsBox extends ConsumerStatefulWidget {
  const TranslationsBox({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TranslationsBoxState();
}

class _TranslationsBoxState extends ConsumerState<TranslationsBox> {
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const BoxTitle(
              title: 'Translations',
              color: AppColors.purple,
            ),
            IconButton(
              onPressed: () {
                node.requestFocus();
              },
              icon: const Icon(Icons.add_rounded, color: AppColors.purple),
            ),
            Expanded(
              child: CustomTextField(
                controller: controller,
                focusNode: node,
                hint: 'Add a translation',
                hintStyle: HintStyle.small,
                textDirection: TextDirection.rtl,
                onEditingComplete: onEditingComplete,
              ),
            ),
          ],
        ),
        const TranslationsWrapWidget(),
      ],
    );
  }

  void onEditingComplete() {
    final text = controller.text.trim();
    if (text.isEmpty) {
      showSnackBar(context, 'The translation is empty');
      return;
    }
    final result = ref.read(wordProvider.notifier).addTranslation(text);
    if (result.success) {
      controller.clear();
    } else {
      showSnackBar(context, result.message);
    }
  }
}
