import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/mappers/tag_mappers.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';
import 'package:lexisnap/features/home/presentation/controllers/tag_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/tag_details/add_or_update_tag_dialog.dart';
import 'package:lexisnap/features/home/presentation/widgets/tag_details/delete_tag_dialog.dart';
import 'package:lexisnap/features/home/presentation/widgets/word_tile_widget.dart';

class TagDetailsPage extends ConsumerWidget {
  static const String path = 'tag-details';
  static const String name = 'Tag-Details-Page';
  const TagDetailsPage({super.key});

  bool contains(Word word, String tagId) {
    return word.tags.any((t) => t.id == tagId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tag = ref.watch(tagProvider);
    final allWords = ref.watch(allWordsProvider);
    return tag == null
        ? const Loading()
        : Builder(
            builder: (context) {
              final tagWords = allWords.where((word) => contains(word, tag.id));
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: AppText(text: '#${tag.name}'),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.edit_rounded, color: AppColors.blue),
                          onPressed: () {
                            showAdaptiveDialog(
                              context: context,
                              builder: (context) => AddOrUpdateTagDialog(
                                update: true,
                                tag: tag.toMinimal(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.delete_rounded, color: Colors.red),
                          onPressed: () async {
                            final deleted = await showAdaptiveDialog<bool>(
                              context: context,
                              builder: (context) => DeleteTagDialog(tagId: tag.id),
                            );
                            if (deleted == null) {
                              return;
                            }
                            if (deleted) {
                              // ignore: use_build_context_synchronously
                              showSnackBar(context,
                                  'Tag deleted successfully.\nRefresh the home page to see the latest updates.');
                              // ignore: use_build_context_synchronously
                              GoRouter.of(context).pop();
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    SliverList.builder(
                      itemBuilder: (context, index) => WordTileWidget(
                        word: tagWords.elementAt(index),
                        ref: ref,
                      ),
                      itemCount: tagWords.length,
                    ),
                  ],
                ),
              );
            },
          );
  }
}
