import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/widgets.dart';

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
          child: const GradientText(
            text: 'Stay',
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 4, 112, 201),
                Colors.lightBlueAccent,
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () => GoRouter.of(context).pop(true),
          child: const GradientText(
            text: 'Exit Anyway',
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
