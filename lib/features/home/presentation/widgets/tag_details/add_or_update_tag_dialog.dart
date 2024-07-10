import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/models/create_or_update_tag_request.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/presentation/controllers/tag_controller.dart';

class AddOrUpdateTagDialog extends ConsumerStatefulWidget {
  final bool update;
  final MinimalTag? tag;
  const AddOrUpdateTagDialog({
    super.key,
    this.update = false,
    this.tag,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddOrUpdateTagDialogState();
}

class _AddOrUpdateTagDialogState extends ConsumerState<AddOrUpdateTagDialog> {
  late final TextEditingController controller;
  late final FocusNode node;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    if (widget.update) {
      controller.text = widget.tag!.name;
    }
    node = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: widget.update ? const Text('Update the tag') : const Text('Add a new tag'),
      content: TextField(
        controller: controller,
        focusNode: node..requestFocus(),
        cursorColor: AppColors.pink,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: AppColors.pink,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              color: AppColors.pink,
            ),
          ),
          hintText: widget.update ? 'Update the tag' : 'Enter a new tag',
        ),
        onEditingComplete: widget.update ? updateTag : createTag,
      ),
      actions: [
        TextButton(
          onPressed: cancel,
          child: const AppText(
            text: 'Cancel',
            color: AppColors.blue,
          ),
        ),
        TextButton(
          onPressed: widget.update ? updateTag : createTag,
          child: AppText(
            text: widget.update ? 'Update' : 'Add',
            color: AppColors.pink,
          ),
        ),
      ],
    );
  }

  void createTag() {
    final tagName = controller.text.trim();
    if (tagName.isEmpty) {
      showSnackBar(context, 'Tag name cannot be empty');
      return;
    }
    ref.read(tagControllerProvider.notifier).createTag(
          context,
          CreateOrUpdateTagRequest(name: tagName),
        );
    GoRouter.of(context).pop();
  }

  void updateTag() {
    final tagName = controller.text.trim();
    if (tagName.isEmpty) {
      showSnackBar(context, 'Tag name cannot be empty');
      return;
    }
    if (tagName == widget.tag!.name) {
      cancel();
      return;
    }
    ref.read(tagControllerProvider.notifier).updateTag(
          context: context,
          tag: CreateOrUpdateTagRequest(name: tagName),
          id: widget.tag!.id,
        );
    GoRouter.of(context).pop();
  }

  void cancel() {
    GoRouter.of(context).pop();
  }
}
