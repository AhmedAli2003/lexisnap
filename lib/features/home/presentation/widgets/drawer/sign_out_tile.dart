import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/drawer/drawer_tile.dart';
import 'package:lexisnap/features/home/presentation/widgets/sign_out_dialog.dart';

class SignOutTile extends ConsumerWidget {
  const SignOutTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DrawerTile(
      title: 'Sign Out',
      icon: const Icon(
        Icons.logout_rounded,
        size: 28,
        color: Colors.red,
      ),
      onTap: () => _signOut(context, ref),
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
