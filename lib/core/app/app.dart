import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/constants/app_constants.dart';
import 'package:lexisnap/core/router/app_router.dart';
import 'package:lexisnap/core/shared/shared_preferences_manager.dart';
import 'package:lexisnap/core/theme/app_theme.dart';
import 'package:lexisnap/features/auth/data/repositories/auth_repository_impl.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    checkAccessToken(ref);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Lexisnap',
      theme: AppTheme.light,
      // home: const AuthGuard(),
      routerConfig: ref.watch(routerProvider).router,
    );
  }

  void checkAccessToken(WidgetRef ref) {
    final days = ref.read(sharedPrefProvider).getExpirationRemainingDays();
    if (days < AppConstants.limitDaysToUpdateAccessToken) {
      ref.read(authRepositoryProvider).signOut();
    }
  }
}
