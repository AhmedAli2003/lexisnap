import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/theme/app_colors.dart';

class CancelAndPopButton extends StatelessWidget {
  const CancelAndPopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        GoRouter.of(context).pop();
      },
      child: const Text(
        'Cancel',
        style: TextStyle(
          color: AppColors.blue,
        ),
      ),
    );
  }
}
