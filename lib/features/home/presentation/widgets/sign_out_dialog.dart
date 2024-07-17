import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/widgets.dart';

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
          child: const GradientText(
            text: 'Back',
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 4, 112, 201),
                Colors.lightBlueAccent,
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: signOut,
          child: const GradientText(
            text: 'Sign Out',
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
