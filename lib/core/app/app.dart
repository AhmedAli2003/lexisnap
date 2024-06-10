import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/constants/app_constants.dart';
import 'package:lexisnap/core/shared/shared_preferences_manager.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_theme.dart';
import 'package:lexisnap/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lexisnap/features/auth/presentation/pages/auth_page.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    checkAccessToken(ref);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lexisnap',
      theme: AppTheme.light,
      home: const AuthGuard(),
    );
  }

  void checkAccessToken(WidgetRef ref) {
    final days = ref.read(sharedPrefProvider).getExpirationRemainingDays();
    if (days < AppConstants.limitDaysToUpdateAccessToken) {
      ref.read(authRepositoryProvider).signOut();
    }
  }
}

class AuthGuard extends ConsumerStatefulWidget {
  const AuthGuard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthGuardState();
}

class _AuthGuardState extends ConsumerState<AuthGuard> {
  void getUserIfAuthenticated() async {
    final user = ref.read(authStateChangeProvider).value;
    if (user != null) {
      await ref.read(authControllerProvider.notifier).getUserFromBackend(context, user);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getUserIfAuthenticated();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appUser = ref.watch(userProvider);
    return ref.watch(authStateChangeProvider).when(
          data: (user) {
            if (user == null) {
              return const AuthPage();
            }
            if (appUser == null) {
              return const Scaffold(
                body: Center(
                  child: FlutterLogo(size: 64),
                ),
              );
            }
            return const HomePage();
          },
          error: (error, _) => const Scaffold(
            body: Text('Error'),
          ),
          loading: () => const Scaffold(
            body: Loading(),
          ),
        );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(authControllerProvider.notifier).signOut(context);
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
