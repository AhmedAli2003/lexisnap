import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/features/contact_us/presentation/contact_us_page.dart';
import 'package:lexisnap/features/home/presentation/pages/tags_page.dart';
import 'package:lexisnap/features/home/presentation/widgets/drawer/drawer_tile.dart';
import 'package:lexisnap/features/home/presentation/widgets/drawer/drawer_title.dart';
import 'package:lexisnap/features/home/presentation/widgets/drawer/sign_out_tile.dart';
import 'package:lexisnap/features/settings/pages/settings_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerTitle(),
          const SizedBox(height: 24),
          DrawerTile(
            title: 'Tags',
            icon: Icons.tag_rounded,
            onTap: () => _navigateToTags(context),
          ),
          const SizedBox(height: 16),
          DrawerTile(
            title: 'Change App Font',
            icon: Icons.font_download_rounded,
            onTap: () => _navigateToSettings(context),
          ),
          const SizedBox(height: 16),
          DrawerTile(
            title: 'Our Extension !!',
            icon: Icons.extension_rounded,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          DrawerTile(
            title: 'Contact Us',
            icon: Icons.message_rounded,
            onTap: () => _navigateToContactUs(context),
          ),
          const Spacer(),
          const SignOutTile(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _navigateToTags(BuildContext context) {
    GoRouter.of(context).pushNamed(TagsPage.name);
  }

  void _navigateToSettings(BuildContext context) {
    GoRouter.of(context).pushNamed(SettingsPage.name);
  }

  void _navigateToContactUs(BuildContext context) {
    GoRouter.of(context).pushNamed(ContactUsPage.name);
  }
}
