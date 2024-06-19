import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/models/update_word_request.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';

class SaveWordIconButton extends ConsumerWidget {
  const SaveWordIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final word = ref.watch(wordProvider)!;
    return IconButton(
      onPressed: () {
        ref.read(wordControllerProvider.notifier).updateWord(
              context: context,
              id: word.id,
              word: UpdateWordRequest.fromWord(word),
            );
      },
      icon: const Icon(
        Icons.save_rounded,
        color: AppColors.blue,
      ),
    );
  }
}
