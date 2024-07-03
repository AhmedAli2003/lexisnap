import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/box_title.dart';
import 'package:lexisnap/features/home/presentation/widgets/tags_widgets/tag_widget.dart';

class DisplayTagsBox extends ConsumerWidget {
  const DisplayTagsBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(wordTagsProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const BoxTitle(title: 'Tags', color: AppColors.pink),
        const SizedBox(height: 12),
        Wrap(
          children: tags.map((tag) => TagWidget(tag: tag)).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
