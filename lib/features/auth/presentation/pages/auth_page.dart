import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lexisnap/features/auth/presentation/widgets/google_sign_in_button.dart';

class AuthPage extends ConsumerWidget {
  static const String path = '/auth';
  static const String name = 'Auth-Page';

  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.scaffoldBackgroundColor,
              Color.fromRGBO(20, 20, 25, 0.75),
              Color.fromRGBO(20, 20, 25, 0.5),
              Color.fromRGBO(20, 20, 25, 0.25),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ref.watch(authControllerProvider)
            ? const Loading()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/lexisnap.svg',
                    width: 300,
                    height: 80,
                  ),
                  const SizedBox(height: 32),
                  const SignInButton(),
                ],
              ),
      ),
    );
  }
}
