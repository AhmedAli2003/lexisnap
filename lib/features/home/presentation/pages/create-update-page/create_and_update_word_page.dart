import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/models/update_word_request.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/pages/create-update-page/create_page_scaffold.dart';
import 'package:lexisnap/features/home/presentation/pages/create-update-page/update_page_scaffold.dart';
import 'package:lexisnap/features/home/presentation/widgets/cancel_button.dart';

// This provider to switch between create and update UI
final isCreateProvider = StateProvider.autoDispose<bool>((_) => true);

// This implementation is used because the create and update word
// have similar UI
class CreateOrUpdateWordPage extends ConsumerWidget {
  static const String path = 'create-or-update-word';
  static const String name = 'Create-Or-Update-Word-Page';
  const CreateOrUpdateWordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(wordProvider);
    return PopScope(
      canPop: !ref.watch(wordChangesProvider),
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final pop = await showAdaptiveDialog<bool>(
          context: context,
          builder: (context) => const CancelBeforeUpdateAlertDialog(),
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
      },
      child: ref.watch(isCreateProvider)
          ? const CreatePageScaffold()
          : ref.watch(wordControllerProvider).updateWord
              ? const LoadingScaffold()
              : const UpdatePageScaffold(),
    );
  }
}
