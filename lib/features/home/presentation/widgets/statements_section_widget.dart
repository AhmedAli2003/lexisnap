import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/models/update_statement_request.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/statement_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/custom_text_field.dart';
import 'package:lexisnap/features/home/presentation/widgets/delete_statement_dialog.dart';
import 'package:lexisnap/features/home/presentation/widgets/field_title_card.dart';

final selectedStatementToUpdateProvider = StateProvider.autoDispose<String>((ref) => '');

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
    final loading = ref.watch(statementControllerProvider);
    final selectedStatementToUpdate = ref.watch(selectedStatementToUpdateProvider);
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
          if (selectedStatementToUpdate == statement.id)
            if (!loading.updateStatement) ...[
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
                    if (text.isNotEmpty) {
                      await ref.read(statementControllerProvider.notifier).updateStatement(
                            context: context,
                            id: ref.read(selectedStatementToUpdateProvider),
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
                      ref.read(selectedStatementToUpdateProvider.notifier).state = '';
                      updateStatementController.clear();
                      updateStatementTranslationController.clear();
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => DeleteStatementDialog(statement: statement),
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
            ] else ...const [
              Loading(),
              SizedBox(height: 12),
            ]
          else
            GestureDetector(
              onTap: () {
                ref.read(selectedStatementToUpdateProvider.notifier).state = statement.id;
              },
              // child: StatementWidget(statement: statement),
            ),
        if (showTextFields)
          if (!loading.createStatement) ...[
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
                    // await ref.read(statementControllerProvider.notifier).createStatement(
                    //       context,
                    //       CreateStatementRequest(
                    //         text: text,
                    //         translation: translation,
                    //         word: word.id,
                    //       ),
                    //     );
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
            Loading(),
          ]
      ],
    );
  }
}
