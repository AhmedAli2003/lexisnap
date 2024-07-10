import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';

class SignOutDialog extends StatelessWidget {
  final VoidCallback signOut;
  const SignOutDialog({super.key, required this.signOut});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: const AppText(
            text: 'Back',
            color: AppColors.blue,
          ),
        ),
        TextButton(
          onPressed: signOut,
          child: const AppText(
            text: 'Sign Out',
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
