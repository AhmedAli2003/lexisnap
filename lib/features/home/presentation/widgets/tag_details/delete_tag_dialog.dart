import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/home/presentation/controllers/tag_controller.dart';

class DeleteTagDialog extends ConsumerWidget {
  final String tagId;
  const DeleteTagDialog({
    super.key,
    required this.tagId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog.adaptive(
      title: const AppText(text: 'Delete the tag'),
      content: const AppText(text: 'Are you sure you want to delete this tag?'),
      actions: [
        TextButton(
          onPressed: () {
            GoRouter.of(context).pop(false);
          },
          child: const GradientText(
            text: 'Cancel',
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 4, 112, 201),
                Colors.lightBlueAccent,
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            ref.read(tagControllerProvider.notifier).deleteTag(context, tagId);
            GoRouter.of(context).pop(true);
          },
          child: const GradientText(
            text: 'Delete',
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Color.fromARGB(255, 240, 124, 115),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
