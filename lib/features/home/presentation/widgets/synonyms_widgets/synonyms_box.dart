import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/box_title.dart';
import 'package:lexisnap/features/home/presentation/widgets/synonyms_widgets/synonym_widget.dart';
import 'package:lexisnap/features/home/presentation/widgets/synonyms_widgets/synonyms_dialog.dart';

class SynonymsBox extends ConsumerWidget {
  const SynonymsBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final synonyms = ref.watch(wordSynonymsProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const BoxTitle(title: 'Synonyms', color: AppColors.green),
            IconButton(
              onPressed: () {
                showModalBottomSheet(context: context, builder: (context) => const SynonymsDialog());
              },
              icon: const Icon(
                Icons.add_rounded,
                color: AppColors.green,
              ),
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: synonyms.map((s) => SynonymWidget(synonym: s)).toList(),
        ),
      ],
    );
  }
}
