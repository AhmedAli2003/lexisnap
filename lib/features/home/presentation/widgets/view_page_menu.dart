import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/pages/create-update-page/update_word_page.dart';
import 'package:lexisnap/features/home/presentation/widgets/opposites_widgets/selected_opposites_provider.dart';
import 'package:lexisnap/features/home/presentation/widgets/synonyms_widgets/selected_synonyms_provider.dart';
import 'package:lexisnap/features/home/presentation/widgets/tags_widgets/selected_tags_provider.dart';

class ViewPageMenu extends ConsumerWidget {
  const ViewPageMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () => navigateToUpdate(context, ref),
            child: const ListTile(
              leading: Icon(
                Icons.edit_rounded,
                color: AppColors.blue,
              ),
              title: AppText(text: 'Update the word'),
            ),
          ),
          PopupMenuItem(
            onTap: () => deleteWord(context, ref),
            child: const ListTile(
              leading: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              title: AppText(text: 'Delete the word'),
            ),
          ),
        ];
      },
    );
  }

  void navigateToUpdate(BuildContext context, WidgetRef ref) {
    //TODO: Explain
    final word = ref.read(wordProvider)!;
    ref.read(selectedTagsProvider.notifier).addAll(word.tags);
    ref.read(selectedSynonymsProvider.notifier).addAll(word.synonyms);
    ref.read(selectedOppositesProvider.notifier).addAll(word.opposites);
    GoRouter.of(context).pushNamed(UpdateWordPage.name);
  }

  void deleteWord(BuildContext context, WidgetRef ref) {
    final id = ref.read(wordProvider)!.id;
    ref.read(wordControllerProvider.notifier).deleteWord(context, id);
    GoRouter.of(context).pop();
  }
}
