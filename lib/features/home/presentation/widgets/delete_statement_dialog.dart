import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';
import 'package:lexisnap/features/home/presentation/controllers/statement_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/statements_section_widget.dart';

class DeleteStatementDialog extends ConsumerWidget {
  final Statement statement;
  const DeleteStatementDialog({
    super.key,
    required this.statement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog.adaptive(
      title: const Text(
        'The statement will be removed',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: AppColors.blue,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            ref.read(statementControllerProvider.notifier).deleteStatement(
                  context,
                  ref.read(selectedStatementToUpdateProvider),
                );
            ref.read(wordProvider.notifier).removeStatement(statement.id);
            GoRouter.of(context).pop();
          },
          child: const Text(
            'Delete',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
