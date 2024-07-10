import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/widgets.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AppText(
          text: 'Hi, ',
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        AppText(
          text: name,
          fontSize: 26,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
