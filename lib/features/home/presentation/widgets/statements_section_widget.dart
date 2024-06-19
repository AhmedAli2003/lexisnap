import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/models/create_statement_request.dart';
import 'package:lexisnap/core/models/update_statement_request.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';
import 'package:lexisnap/features/home/presentation/controllers/statement_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/custom_text_field.dart';
import 'package:lexisnap/features/home/presentation/widgets/field_title_card.dart';
import 'package:lexisnap/features/home/presentation/widgets/speak_icon.dart';

final selectedStatementToUpdate = StateProvider.autoDispose<String>((ref) => '');

class StatementsSectionWidget extends ConsumerStatefulWidget {
  const StatementsSectionWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatementsSectionWidgetState();
}

class _StatementsSectionWidgetState extends ConsumerState<StatementsSectionWidget> {
  final TextEditingController statementController = TextEditingController();
  final TextEditingController statementTranslationController = TextEditingController();
  final FocusNode statementFocusNode = FocusNode();
  final FocusNode statementTranslationFocusNode = FocusNode();

  // Update
  final TextEditingController updateStatementController = TextEditingController();
  final TextEditingController updateStatementTranslationController = TextEditingController();
  final FocusNode updateStatementFocusNode = FocusNode();
  final FocusNode updateStatementTranslationFocusNode = FocusNode();

  bool showTextFields = false;

  @override
  void dispose() {
    statementController.dispose();
    statementTranslationController.dispose();
    statementFocusNode.dispose();
    statementTranslationFocusNode.dispose();

    //Update
    updateStatementController.dispose();
    updateStatementTranslationController.dispose();
    updateStatementFocusNode.dispose();
    updateStatementTranslationFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final word = ref.watch(wordProvider)!;
    return Column(
      children: [
        Row(
          children: [
            const FieldTitleCard(title: 'Example Statements'),
            IconButton(
              onPressed: () {
                setState(() => showTextFields = !showTextFields);
                statementFocusNode.requestFocus();
              },
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
        for (final statement in word.statements)
          if (!ref.watch(statementControllerProvider).updateStatement)
            if (ref.watch(selectedStatementToUpdate) == statement.id) ...[
              CustomTextField(
                hintStyle: HintStyle.small,
                controller: updateStatementController..text = statement.text,
                focusNode: updateStatementFocusNode..requestFocus(),
                onEditingComplete: () {
                  updateStatementTranslationFocusNode.requestFocus();
                },
              ),
              const Divider(),
              CustomTextField(
                controller: updateStatementTranslationController..text = statement.translation,
                focusNode: updateStatementTranslationFocusNode,
                hintStyle: HintStyle.small,
                onEditingComplete: () {
                  updateStatementTranslationFocusNode.unfocus();
                },
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    updateStatementFocusNode.unfocus();
                    updateStatementTranslationFocusNode.unfocus();
                    final text = updateStatementController.text.trim();
                    final translation = updateStatementTranslationController.text.trim();
                    updateStatementController.clear();
                    updateStatementTranslationController.clear();
                    if (text.isNotEmpty) {
                      await ref.read(statementControllerProvider.notifier).updateStatement(
                            context: context,
                            id: ref.read(selectedStatementToUpdate),
                            statement: UpdateStatementRequest(
                              text: text,
                              translation: translation,
                            ),
                          );
                      final statement = ref.read(statementProvider);
                      if (statement != null) {
                        ref.read(wordProvider.notifier).updateStatement(statement);
                        ref.read(statementProvider.notifier).state = null;
                      }
                      ref.read(selectedStatementToUpdate.notifier).state = '';
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog.adaptive(
                          title: const Text('The statement will be removed'),
                          actions: [
                            TextButton(
                              onPressed: () {},
                              child: const Text('Delete'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Save Statement',
                    style: TextStyle(
                      color: AppColors.blue,
                    ),
                  ),
                ),
              ),
            ] else
              GestureDetector(
                onTap: () {
                  ref.read(selectedStatementToUpdate.notifier).state = statement.id;
                },
                child: StatementWidget(statement: statement),
              )
          else ...const [Loading()],
        if (showTextFields)
          if (!ref.watch(statementControllerProvider).createStatement) ...[
            CustomTextField(
              hint: 'Write a statement',
              hintStyle: HintStyle.small,
              controller: statementController,
              focusNode: statementFocusNode,
              onEditingComplete: () {
                statementTranslationFocusNode.requestFocus();
              },
            ),
            const Divider(),
            CustomTextField(
              controller: statementTranslationController,
              focusNode: statementTranslationFocusNode,
              hint: 'Write a statement translation if you want',
              hintStyle: HintStyle.small,
              onEditingComplete: () {
                statementTranslationFocusNode.unfocus();
              },
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  statementFocusNode.unfocus();
                  statementTranslationFocusNode.unfocus();
                  final text = statementController.text.trim();
                  final translation = statementTranslationController.text.trim();
                  statementController.clear();
                  statementTranslationController.clear();
                  if (text.isNotEmpty) {
                    await ref.read(statementControllerProvider.notifier).createStatement(
                          context,
                          CreateStatementRequest(
                            text: text,
                            translation: translation,
                            word: word.id,
                          ),
                        );
                    final statement = ref.read(statementProvider);
                    if (statement != null) {
                      ref.read(wordProvider.notifier).addStatement(statement);
                      ref.read(statementProvider.notifier).state = null;
                    }
                    setState(() => showTextFields = false);
                  }
                },
                child: const Text(
                  'Save Statement',
                  style: TextStyle(
                    color: AppColors.blue,
                  ),
                ),
              ),
            ),
          ] else ...const [
            SizedBox(height: 20),
            Loading()
          ]
      ],
    );
  }
}

class StatementWidget extends StatelessWidget {
  final Statement statement;
  const StatementWidget({super.key, required this.statement});

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  statement.text,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  statement.translation,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.yellow,
                  ),
                ),
              ],
            ),
          ),
        ),
        SpeakIcon(
          text: statement.text,
          size: 24,
        ),
      ],
    );
  }
}
