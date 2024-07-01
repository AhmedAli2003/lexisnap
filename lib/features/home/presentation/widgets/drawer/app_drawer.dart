import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/drawer/drawer_tile.dart';
import 'package:lexisnap/features/home/presentation/widgets/sign_out_dialog.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(user.profilePicture),
                ),
                const SizedBox(width: 12),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          DrawerTile(
            title: 'Tags',
            icon: Icons.tag_rounded,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          DrawerTile(
            title: 'Our Extension !!',
            icon: Icons.extension_rounded,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          DrawerTile(
            title: 'Settings',
            icon: Icons.settings_rounded,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          DrawerTile(
            title: 'Contact Us',
            icon: Icons.message_rounded,
            onTap: () {},
          ),
          const Spacer(),
          DrawerTile(
            title: 'Sign Out',
            icon: Icons.logout_rounded,
            iconColor: Colors.red,
            onTap: () => _signOut(context, ref),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _signOut(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => SignOutDialog(signOut: () {
        ref.read(authControllerProvider.notifier).signOut(context);
      }),
    );
  }
}
