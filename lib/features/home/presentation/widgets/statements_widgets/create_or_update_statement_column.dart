import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/models/create_statement_request.dart';
import 'package:lexisnap/core/models/update_statement_request.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/statement_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/custom_text_field.dart';
import 'package:lexisnap/features/home/presentation/widgets/statements_widgets/statement_box_state.dart';

class CreateOrUpdateStatementColumn extends ConsumerStatefulWidget {
  const CreateOrUpdateStatementColumn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateOrUpdateStatementColumnState();
}

class _CreateOrUpdateStatementColumnState extends ConsumerState<CreateOrUpdateStatementColumn> {
  late final TextEditingController statementController;
  late final FocusNode statementNode;
  late final TextEditingController translationController;
  late final FocusNode translationNode;

  late final FocusNode buttonNode;

  @override
  void initState() {
    super.initState();
    statementController = TextEditingController();
    statementNode = FocusNode();
    translationController = TextEditingController();
    translationNode = FocusNode();
    buttonNode = FocusNode();
  }

  @override
  void dispose() {
    statementController.dispose();
    statementNode.dispose();
    translationController.dispose();
    translationNode.dispose();
    buttonNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(statementBoxStateProvider);
    final ls = ref.watch(statementControllerProvider);
    final isLoading = ls.createStatement || ls.updateStatement || ls.deleteStatement;
    return isLoading
        ? const Loading()
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: statementController..text = state.statement?.text ?? '',
                focusNode: statementNode..requestFocus(),
                hint: 'Write a statement here',
                onEditingComplete: () {
                  translationNode.requestFocus();
                },
              ),
              const SizedBox(height: 4),
              CustomTextField(
                controller: translationController..text = state.statement?.translation ?? '',
                focusNode: translationNode,
                hint: 'Write a statement translation here',
                onEditingComplete: () {
                  buttonNode.requestFocus();
                },
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () => save(state),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: AppColors.blue,
                  ),
                ),
              ),
            ],
          );
  }

  void save(StatementBoxState state) async {
    final text = statementController.text.trim();
    final translation = translationController.text.trim();

    String? id;
    final wordId = state.wordId;
    if (state.statement != null) {
      id = state.statement!.id;
    }
    if (state.update) {
      if (text.isEmpty) {
        ref.read(statementControllerProvider.notifier).deleteStatement(
              context,
              id!,
            );
      } else {
        await ref.read(statementControllerProvider.notifier).updateStatement(
              context: context,
              id: id!,
              statement: UpdateStatementRequest(
                text: text,
                translation: translation,
              ),
            );
      }
    } else {
      if (text.isNotEmpty) {
        await ref.read(statementControllerProvider.notifier).createStatement(
              context: context,
              statement: CreateStatementRequest(
                word: wordId!,
                text: text,
                translation: translation,
              ),
            );
      } else {
        showSnackBar(context, 'Statement cannot be empty');
        return;
      }
    }

    statementController.clear();
    translationController.clear();
    statementNode.unfocus();
    translationNode.unfocus();
    buttonNode.unfocus();
    ref.read(statementBoxStateProvider.notifier).update(
          (s) => s.copyWith(
            update: false,
            showTextField: false,
            statement: null,
            wordId: null,
          ),
        );
  }
}
