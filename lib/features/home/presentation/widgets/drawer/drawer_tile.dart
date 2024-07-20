import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/widgets.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;
  final Gradient? gradient;
  const DrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: gradient != null
          ? GradientText(
              text: title,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              gradient: gradient!,
            )
          : AppText(
              text: title,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
      onTap: onTap,
    );
  }
}
