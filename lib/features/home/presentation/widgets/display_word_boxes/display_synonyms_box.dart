import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/box_title.dart';
import 'package:lexisnap/features/home/presentation/widgets/synonyms_widgets/synonym_widget.dart';

class DisplaySynonymsBox extends ConsumerWidget {
  const DisplaySynonymsBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final synonyms = ref.watch(wordSynonymsProvider);
    return synonyms.isEmpty
        ? const SizedBox()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const BoxTitle(title: 'Synonyms', color: AppColors.green),
              const SizedBox(height: 12),
              Wrap(
                children: synonyms.map((s) => SynonymWidget(synonym: s)).toList(),
              ),
              const SizedBox(height: 20),
            ],
          );
  }
}
