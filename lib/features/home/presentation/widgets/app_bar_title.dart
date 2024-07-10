import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/widgets.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  const AppBarTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: title,
      fontWeight: FontWeight.w700,
    );
  }
}
