import 'package:flutter/material.dart';

class RemoveTranslationsIconButton extends StatelessWidget {
  final VoidCallback onTap;
  const RemoveTranslationsIconButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: const Icon(
        Icons.delete_forever_rounded,
        color: Colors.red,
      ),
    );
  }
}
