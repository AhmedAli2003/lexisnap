import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Page'),
      ),
      body: ref.watch(authControllerProvider)
          ? const Loading()
          : Center(
              child: ElevatedButton(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).signInWithGoogle(context);
                },
                child: const Text('Sign In'),
              ),
            ),
    );
  }
}
