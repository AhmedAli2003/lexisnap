import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/custom_text_field.dart';
import 'package:lexisnap/features/home/presentation/widgets/field_title_card.dart';
import 'package:lexisnap/features/home/presentation/widgets/speak_icon.dart';

final selectedDefinition = StateProvider.autoDispose<String>((ref) => '');

class DefinitionsSectionWidget extends ConsumerStatefulWidget {
  const DefinitionsSectionWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DefinitionsSectionWidgetState();
}

class _DefinitionsSectionWidgetState extends ConsumerState<DefinitionsSectionWidget> {
  late final TextEditingController controller;
  late final TextEditingController updateController;
  late final FocusNode node;
  late final FocusNode updateNode;

  bool showTextField = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    node = FocusNode();
    updateController = TextEditingController();
    updateNode = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    node.dispose();
    updateController.dispose();
    updateNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final word = ref.watch(wordProvider)!;
    return Column(
      children: [
        Row(
          children: [
            const FieldTitleCard(title: 'Definitions'),
            IconButton(
              onPressed: () {
                setState(() => showTextField = !showTextField);
                updateNode.unfocus();
                ref.read(selectedDefinition.notifier).state = '';
                node.requestFocus();
              },
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
        for (final definition in word.definitions)
          if (ref.watch(selectedDefinition) == definition)
            CustomTextField(
              controller: updateController..text = definition,
              focusNode: updateNode..requestFocus(),
              hintStyle: HintStyle.small,
              onEditingComplete: () {
                ref.read(selectedDefinition.notifier).state = '';
                updateNode.unfocus();
                final text = updateController.text.trim();
                if (text.isNotEmpty) {
                  ref.read(wordProvider.notifier).updateOneDifinition(definition, text);
                } else {
                  ref.read(wordProvider.notifier).deleteDifinition(definition);
                }
                updateController.clear();
              },
            )
          else
            GestureDetector(
              onTap: () {
                ref.read(selectedDefinition.notifier).state = definition;
              },
              child: DifinitionWidget(definition: definition),
            ),
        if (showTextField)
          CustomTextField(
            controller: controller,
            focusNode: node,
            hint: 'Write a word definition',
            hintStyle: HintStyle.small,
            onEditingComplete: () {
              node.unfocus();
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                ref.read(wordProvider.notifier).addDefinition(text);
                controller.clear();
              }
              setState(() => showTextField = false);
            },
          ),
      ],
    );
  }
}

class DifinitionWidget extends StatelessWidget {
  final String definition;
  const DifinitionWidget({
    super.key,
    required this.definition,
  });

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
            child: Text(definition, style: const TextStyle(fontSize: 16)),
          ),
        ),
        SpeakIcon(
          text: definition,
          size: 24,
        ),
      ],
    );
  }
}
