import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/presentation/controllers/tag_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';

class TagsDialog extends ConsumerWidget {
  const TagsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(allTagsProvider);
    return AlertDialog.adaptive(
      title: const Text('Select Tags'),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      content: Wrap(
        children: [
          for (final tag in tags)
            TagCard(
              tag: tag,
            ),
        ],
      ),
    );
  }
}

class TagCard extends ConsumerWidget {
  final MinimalTag tag;
  final bool fromDialog;

  const TagCard({
    super.key,
    required this.tag,
    this.fromDialog = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(wordProvider)!.tags.contains(tag);
    return GestureDetector(
      onTap: () {
        if (fromDialog) {
          if (selected) {
            ref.read(wordProvider.notifier).deleteTag(tag);
          } else {
            ref.read(wordProvider.notifier).addTag(tag);
          }
        } else {
          //TODO: Navigate
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          gradient: selected
              ? const LinearGradient(
                  colors: [
                    AppColors.pink,
                    Color.fromRGBO(255, 166, 201, 0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [
                    AppColors.white,
                    Color.fromRGBO(255, 255, 255, 0.75),
                  ],
                ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Text(
          '#${tag.name}',
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
