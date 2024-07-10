import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
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
      title: const Text('Are you sure?'),
      actions: [
        TextButton(
          onPressed: () {
            GoRouter.of(context).pop(false);
          },
          child: const AppText(
            text: 'Cancel',
            color: AppColors.blue,
          ),
        ),
        TextButton(
          onPressed: () {
            ref.read(tagControllerProvider.notifier).deleteTag(context, tagId);
            GoRouter.of(context).pop(true);
          },
          child: const AppText(
            text: 'Delete',
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
