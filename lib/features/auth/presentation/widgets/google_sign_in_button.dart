import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onTap: () => signInWithGoogle(context, ref),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.deepPurpleAccent,
                Color.fromARGB(255, 171, 151, 226),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/google.png',
                width: 35,
              ),
              const GradientText(
                text: 'Continue with Google',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white70,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
