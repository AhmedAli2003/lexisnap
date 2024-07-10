import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/widgets.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  const DrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: iconColor,
      ),
      title: AppText(
        text: title,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      onTap: onTap,
    );
  }
}
