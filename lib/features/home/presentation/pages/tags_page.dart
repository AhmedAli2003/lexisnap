import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/tag.dart';
import 'package:lexisnap/features/home/presentation/controllers/tag_controller.dart';
import 'package:lexisnap/features/home/presentation/pages/tag_details_page.dart';
import 'package:lexisnap/features/home/presentation/widgets/tag_details/add_or_update_tag_dialog.dart';
import 'package:lexisnap/features/home/presentation/widgets/tag_details/tag_words_count.dart';

class TagsPage extends ConsumerWidget {
  static const String path = 'tags';
  static const String name = 'Tags-Page';
  const TagsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(allTagsProvider);
    final loading = ref.watch(tagControllerProvider).createTag;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            automaticallyImplyLeading: true,
            title: AppText(text: 'Tags'),
          ),
          if (tags.isEmpty)
            const SliverToBoxAdapter(
              child: Center(
                child: Text('There are no tags yet, try to add one.'),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverFixedExtentList.builder(
                itemCount: tags.length + 1,
                itemBuilder: (context, index) {
                  if (index == tags.length) {
                    return loading ? const Loading() : const SizedBox();
                  }
                  final tag = tags[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.tag_rounded,
                        color: AppColors.pink,
                      ),
                      title: Text(tag.name),
                      trailing: TagWordsCount(tagId: tag.id),
                      onTap: () {
                        final t = ref.read(allTagsProvider).firstWhere((t) => t.id == tag.id);
                        ref.read(tagProvider.notifier).update(
                              (state) => Tag(
                                id: t.id,
                                name: t.name,
                                words: const {},
                              ),
                            );
                        GoRouter.of(context).pushNamed(TagDetailsPage.name);
                      },
                    ),
                  );
                },
                itemExtent: 64,
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAdaptiveDialog(
            context: context,
            builder: (context) => const AddOrUpdateTagDialog(),
          );
        },
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(
              colors: [
                Colors.pinkAccent,
                AppColors.pink,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
