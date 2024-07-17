import 'package:flutter/material.dart';
import 'package:lexisnap/features/home/presentation/widgets/box_title.dart';

class TranslationsTitle extends StatelessWidget {
  const TranslationsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const BoxTitle(
      title: 'Translations',
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple,
          Color.fromARGB(255, 185, 164, 241),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    );
  }
}
