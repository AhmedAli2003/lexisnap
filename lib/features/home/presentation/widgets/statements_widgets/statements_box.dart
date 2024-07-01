import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/box_title.dart';
import 'package:lexisnap/features/home/presentation/widgets/statements_widgets/create_or_update_statement_column.dart';
import 'package:lexisnap/features/home/presentation/widgets/statements_widgets/statement_box_state.dart';
import 'package:lexisnap/features/home/presentation/widgets/statements_widgets/statement_widget.dart';

class StatementsBox extends ConsumerWidget {
  const StatementsBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statements = ref.watch(wordStatementsProvider);
    final showTextField = ref.watch(statementBoxStateProvider.select((s) => s.showTextField));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const BoxTitle(title: 'Statements', color: AppColors.blue),
            IconButton(
              icon: const Icon(Icons.add, color: AppColors.blue),
              onPressed: () {
                ref.read(statementBoxStateProvider.notifier).update(
                      (boxState) => boxState.copyWith(
                        showTextField: true,
                        wordId: ref.read(wordProvider)!.id,
                      ),
                    );
              },
            ),
          ],
        ),
        if (statements.isNotEmpty)
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
              children: statements
                  .map(
                    (statement) => GestureDetector(
                      onTap: () {
                        ref.read(statementBoxStateProvider.notifier).update(
                              (boxState) => boxState.copyWith(
                                update: true,
                                showTextField: true,
                                statement: statement,
                                wordId: statement.wordId,
                              ),
                            );
                      },
                      child: StatementWidget(statement: statement),
                    ),
                  )
                  .toList(),
            ),
          ),
        if (showTextField) const CreateOrUpdateStatementColumn(),
      ],
    );
  }
}
