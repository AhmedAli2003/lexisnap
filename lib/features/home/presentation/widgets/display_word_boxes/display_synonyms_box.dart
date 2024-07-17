import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/synonyms_widgets/synonym_widget.dart';
import 'package:lexisnap/features/home/presentation/widgets/synonyms_widgets/synonyms_box.dart';

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
              const SynonymsTitle(),
              const SizedBox(height: 12),
              Wrap(
                children: synonyms.map((s) => SynonymWidget(synonym: s)).toList(),
              ),
              const SizedBox(height: 20),
            ],
          );
  }
}
