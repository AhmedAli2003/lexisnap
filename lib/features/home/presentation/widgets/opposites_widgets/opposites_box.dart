import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/box_title.dart';
import 'package:lexisnap/features/home/presentation/widgets/opposites_widgets/opposite_widget.dart';
import 'package:lexisnap/features/home/presentation/widgets/opposites_widgets/opposites_dialog.dart';

class OppositesBox extends ConsumerWidget {
  const OppositesBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opposites = ref.watch(wordOppositesProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const OppositesTitle(),
            IconButton(
              onPressed: () {
                showModalBottomSheet(context: context, builder: (context) => const OppositesDialog());
              },
              icon: const Icon(
                Icons.add_rounded,
                color: Color.fromARGB(255, 240, 124, 115),
              ),
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: opposites.map((op) => OppositeWidget(opposite: op)).toList(),
        ),
      ],
    );
  }
}

class OppositesTitle extends StatelessWidget {
  const OppositesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const BoxTitle(
      title: 'Opposites',
      gradient: LinearGradient(
        colors: [
          Colors.red,
          Color.fromARGB(255, 240, 124, 115),
        ],
      ),
    );
  }
}
