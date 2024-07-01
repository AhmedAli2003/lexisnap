import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/presentation/controllers/tag_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/tags_widgets/tag_widget.dart';

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
        children: tags
            .map(
              (tag) => TagWidget(
                tag: tag,
                fromDialig: true,
              ),
            )
            .toList(),
      ),
    );
  }
}
