import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/contact_us/presentation/contact_us_page.dart';
import 'package:lexisnap/features/donations/donations_page.dart';
import 'package:lexisnap/features/extension/extension_page.dart';
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
            icon: const Icon(Icons.tag_rounded, size: 28),
            onTap: () => _navigateToTags(context),
          ),
          const SizedBox(height: 16),
          DrawerTile(
            title: 'Change App Font',
            icon: const Icon(Icons.font_download_rounded, size: 28),
            onTap: () => _navigateToSettings(context),
          ),
          const SizedBox(height: 16),
          DrawerTile(
            title: 'Our Extension',
            icon: const Icon(Icons.extension_rounded, size: 28),
            onTap: () => _navigateToExtension(context),
          ),
          const SizedBox(height: 16),
          DrawerTile(
            title: 'Important',
            gradient: const LinearGradient(
              colors: [
                AppColors.blue,
                AppColors.white,
              ],
            ),
            icon: SvgPicture.asset(
              'assets/svgs/hand-holding-heart-solid.svg',
              height: 28,
              width: 28,
              // ignore: deprecated_member_use
              color: AppColors.blue,
            ),
            onTap: () => _navigateToDonations(context),
          ),
          const SizedBox(height: 16),
          DrawerTile(
            title: 'Contact Us',
            icon: const Icon(Icons.message_rounded, size: 28),
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

  void _navigateToExtension(BuildContext context) {
    GoRouter.of(context).pushNamed(ExtensionPage.name);
  }

  void _navigateToDonations(BuildContext context) {
    GoRouter.of(context).pushNamed(DonationsPage.name);
  }
}
