import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/models/update_word_request.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';

class CancelButton extends ConsumerWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => pop(context, ref),
      child: const Text(
        'Cancel',
        style: TextStyle(
          color: AppColors.blue,
        ),
      ),
    );
  }

  void pop(BuildContext context, WidgetRef ref) async {
    final hasChanged = ref.read(wordChangesProvider);
    if (hasChanged) {
      final pop = await showAdaptiveDialog<bool>(
        context: context,
        builder: (_) => const CancelBeforeUpdateAlertDialog(),
      );
      if (pop == null) {
        return;
      }
      if (!pop) {
        final word = ref.read(wordProvider)!;
        await ref.read(wordControllerProvider.notifier).updateWord(
              // ignore: use_build_context_synchronously
              context: context,
              id: word.id,
              word: UpdateWordRequest.fromWord(word),
            );
      } else {
        if (context.mounted) return GoRouter.of(context).pop(); // will cancel without updating
      }
    } else {
      ref.read(wordProvider.notifier).dispose();
      return GoRouter.of(context).pop();
    }
  }
}

class CancelBeforeUpdateAlertDialog extends StatelessWidget {
  const CancelBeforeUpdateAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Unsaved Changes!'),
      content: const Text('Are you sure you want to cancel without saving changes!'),
      actions: [
        TextButton(
          onPressed: () {
            // Cancel without saving changes
            GoRouter.of(context).pop(true);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            // Save changes before cancelling
            GoRouter.of(context).pop(false);
          },
          child: const Text(
            'Save changes',
            style: TextStyle(color: AppColors.blue),
          ),
        ),
      ],
    );
  }
}
