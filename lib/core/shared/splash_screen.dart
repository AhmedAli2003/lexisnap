import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/tag_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const String path = '/splash';
  static const String name = 'Splash-Screen';
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      // checkAccessToken();
      final user = ref.read(authStateChangeProvider).value;
      if (user != null) {
        await ref.read(authControllerProvider.notifier).getUserFromBackend(context, user);
        Future.delayed(Duration.zero, () {
          ref.read(wordControllerProvider.notifier).getAllWords(context, 1);
          ref.read(wordControllerProvider.notifier).getWordsOverview(context);
          ref.read(tagControllerProvider.notifier).getAllTags(context, 1);
        });
      }
    });
  }

  // void checkAccessToken() {
  //   final days = ref.read(sharedPrefProvider).getExpirationRemainingDays();
  //   if (days < AppConstants.limitDaysToUpdateAccessToken) {
  //     ref.read(authRepositoryProvider).signOut();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
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
        child: SvgPicture.asset(
          'assets/svgs/lexisnap.svg',
          width: 300,
          height: 80,
        ),
      ),
    );
  }
}
