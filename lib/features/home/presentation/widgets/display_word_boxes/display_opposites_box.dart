import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/box_title.dart';
import 'package:lexisnap/features/home/presentation/widgets/opposites_widgets/opposite_widget.dart';

class DisplayOppositesBox extends ConsumerWidget {
  const DisplayOppositesBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opposites = ref.watch(wordOppositesProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const BoxTitle(title: 'Opposites', color: Colors.red),
        const SizedBox(height: 12),
        Wrap(
          children: opposites.map((op) => OppositeWidget(opposite: op)).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
