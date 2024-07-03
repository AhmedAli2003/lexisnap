import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/string_utils.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/box_title.dart';
import 'package:lexisnap/features/home/presentation/widgets/speak_icon.dart';

class DisplayStatementsBox extends ConsumerWidget {
  const DisplayStatementsBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statements = ref.watch(wordStatementsProvider);
    return statements.isEmpty
        ? const SizedBox()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const BoxTitle(title: 'Example Statements', color: AppColors.blue),
              const SizedBox(height: 12),
              ...statements.map((s) => DisplayStatementContainer(statement: s)),
              const SizedBox(height: 20),
            ],
          );
  }
}

class DisplayStatementContainer extends StatelessWidget {
  final Statement statement;
  const DisplayStatementContainer({super.key, required this.statement});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.grey,
                  Color.fromRGBO(39, 41, 48, 0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  statement.text,
                  style: const TextStyle(fontSize: 16),
                ),
                if (statement.translation.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: SelectableText(
                      statement.translation,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.yellow,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SpeakIcon(text: StringUtils.removeSpecialCharacters(statement.text)),
      ],
    );
  }
}
