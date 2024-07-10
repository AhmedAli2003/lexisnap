import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Row(
        children: [
          Icon(Icons.warning, color: Colors.orange),
          SizedBox(width: 8),
          AppText(text: 'Unsaved Changes'),
        ],
      ),
      content: const Text('You have unsaved changes. Do you want to exit without saving?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => GoRouter.of(context).pop(false),
          child: const AppText(text: 'Stay', color: AppColors.blue),
        ),
        TextButton(
          onPressed: () => GoRouter.of(context).pop(true),
          child: const AppText(text: 'Exit Anyway', color: Colors.red),
        ),
      ],
    );
  }
}
