import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/speak_icon.dart';

class DisplayWordTextBox extends ConsumerWidget {
  const DisplayWordTextBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final word = ref.watch(wordTextProvider);
    return Row(
      children: [
        const Icon(
          Icons.menu_book_rounded,
          size: 32,
        ),
        const SizedBox(width: 8),
        AppSelectableText(
          text: word,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        const Spacer(),
        SpeakIcon(
          text: word,
          id: ref.read(wordProvider)?.id ?? '',
        ),
      ],
    );
  }
}
