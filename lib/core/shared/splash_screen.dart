import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        Future.delayed(Duration.zero, () async {
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
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 128,
        ),
      ),
    );
  }
}
