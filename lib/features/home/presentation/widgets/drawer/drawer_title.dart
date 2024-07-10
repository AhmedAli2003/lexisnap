import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';

class DrawerTitle extends ConsumerWidget {
  const DrawerTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return DrawerHeader(
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: user.profilePicture,
            width: 64,
            height: 64,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 32,
              backgroundImage: imageProvider,
            ),
          ),
          const SizedBox(width: 12),
          AppText(
            text: user.name,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ],
      ),
    );
  }
}
