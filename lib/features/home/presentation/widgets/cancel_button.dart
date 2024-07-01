import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/theme/app_colors.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => pop(context),
      child: const Text(
        'Cancel',
        style: TextStyle(
          color: AppColors.blue,
        ),
      ),
    );
  }

  void pop(BuildContext context) {
    GoRouter.of(context).pop();
  }
}
