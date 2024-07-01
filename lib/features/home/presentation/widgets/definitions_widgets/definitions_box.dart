import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/box_title.dart';
import 'package:lexisnap/features/home/presentation/widgets/custom_text_field.dart';
import 'package:lexisnap/features/home/presentation/widgets/definitions_widgets/definition_widget.dart';

class DefinitionsBox extends ConsumerStatefulWidget {
  const DefinitionsBox({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DefinitionsBoxState();
}

class _DefinitionsBoxState extends ConsumerState<DefinitionsBox> {
  late final TextEditingController controller;
  late final FocusNode node;

  bool showTextField = false;
  bool update = false;
  String definitionToUpdate = '';

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
    final definitions = ref.watch(wordDefinitionsProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const BoxTitle(
              title: 'Definitions',
              color: AppColors.white,
            ),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.add_rounded, color: AppColors.white),
            ),
          ],
        ),
        if (definitions.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(39, 41, 48, 0.5),
                  AppColors.grey,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: definitions
                  .map(
                    (d) => GestureDetector(
                      onTap: () {
                        setState(() {
                          showTextField = true;
                          update = true;
                          definitionToUpdate = d;
                        });
                        node.requestFocus();
                        controller.text = d;
                      },
                      child: DefinitionWidget(definition: d),
                    ),
                  )
                  .toList(),
            ),
          ),
        if (showTextField)
          CustomTextField(
            controller: controller,
            focusNode: node..requestFocus(),
            hint: 'Write a definition here',
            onEditingComplete: update
                ? () => onEditingComplete(
                      oldDefinition: definitionToUpdate,
                    )
                : onEditingComplete,
          ),
      ],
    );
  }

  void onPressed() {
    setState(() => showTextField = true);
  }

  void onEditingComplete({String? oldDefinition}) {
    final definition = controller.text.trim();
    if (update) {
      if (definition.isEmpty) {
        ref.read(wordProvider.notifier).removeDifinition(oldDefinition!);
      } else {
        ref.read(wordProvider.notifier).updateOneDifinition(oldDefinition!, definition);
      }
    } else {
      if (definition.isEmpty) {
        showSnackBar(context, 'The definition is empty');
        return;
      }
      ref.read(wordProvider.notifier).addDefinition(definition);
    }
    controller.clear();
    node.unfocus();
    showTextField = false;
    update = false;
    oldDefinition = '';
    setState(() {});
  }
}
