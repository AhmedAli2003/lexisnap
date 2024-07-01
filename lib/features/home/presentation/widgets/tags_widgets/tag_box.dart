import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/box_title.dart';
import 'package:lexisnap/features/home/presentation/widgets/tags_widgets/tag_widget.dart';
import 'package:lexisnap/features/home/presentation/widgets/tags_widgets/tags_dialog.dart';

class TagsBox extends ConsumerWidget {
  const TagsBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(wordTagsProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const BoxTitle(title: 'Tags', color: AppColors.pink),
            IconButton(
              onPressed: () {
                showAdaptiveDialog(context: context, builder: (context) => const TagsDialog());
              },
              icon: const Icon(
                Icons.add_rounded,
                color: AppColors.pink,
              ),
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: tags.map((tag) => TagWidget(tag: tag)).toList(),
        ),
      ],
    );
  }
}

