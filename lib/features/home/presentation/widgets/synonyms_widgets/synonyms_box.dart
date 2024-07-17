import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            const SynonymsTitle(),
            IconButton(
              onPressed: () {
                showModalBottomSheet(context: context, builder: (context) => const SynonymsDialog());
              },
              icon: const Icon(
                Icons.add_rounded,
                color: Colors.greenAccent,
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

class SynonymsTitle extends StatelessWidget {
  const SynonymsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const BoxTitle(
      title: 'Synonyms',
      gradient: LinearGradient(
        colors: [
          Colors.green,
          Colors.greenAccent,
        ],
      ),
    );
  }
}
