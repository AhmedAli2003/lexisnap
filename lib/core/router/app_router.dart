import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/splash_screen.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lexisnap/features/auth/presentation/pages/auth_page.dart';
import 'package:lexisnap/features/contact_us/presentation/contact_us_page.dart';
import 'package:lexisnap/features/donations/donations_page.dart';
import 'package:lexisnap/features/extension/extension_page.dart';
import 'package:lexisnap/features/home/presentation/pages/create-update-page/create_and_update_word_page.dart';
import 'package:lexisnap/features/home/presentation/pages/create-update-page/update_word_page.dart';
import 'package:lexisnap/features/home/presentation/pages/home_page.dart';
import 'package:lexisnap/features/home/presentation/pages/tag_details_page.dart';
import 'package:lexisnap/features/home/presentation/pages/tags_page.dart';
import 'package:lexisnap/features/home/presentation/pages/view_word_page.dart';
import 'package:lexisnap/features/settings/pages/settings_page.dart';

final routerProvider = Provider<AppRouter>((ref) => AppRouter(ref: ref));
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final Ref _ref;

  static const List<String> _specials = [
    HomePage.path,
    AuthPage.path,
    SplashScreen.path,
  ];

  AppRouter({required Ref ref}) : _ref = ref;

  GoRouter get router => _router;

  late final _router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: SplashScreen.path,
    routes: [
      GoRoute(
        path: SplashScreen.path,
        name: SplashScreen.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AuthPage.path,
        name: AuthPage.name,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: HomePage.path,
        name: HomePage.name,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: CreateOrUpdateWordPage.path,
            name: CreateOrUpdateWordPage.name,
            pageBuilder: (context, state) => CustomTransitionPage(
              name: CreateOrUpdateWordPage.name,
              child: const CreateOrUpdateWordPage(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) =>
                  FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            path: ViewWordPage.path,
            name: ViewWordPage.name,
            pageBuilder: (context, state) => CustomTransitionPage(
              name: ViewWordPage.name,
              child: const ViewWordPage(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) =>
                  FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
            routes: [
              GoRoute(
                path: UpdateWordPage.path,
                name: UpdateWordPage.name,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    name: UpdateWordPage.name,
                    child: const UpdateWordPage(),
                    transitionsBuilder: (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) =>
                        SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: const Offset(0, 0),
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: TagsPage.path,
            name: TagsPage.name,
            pageBuilder: (context, state) => CustomTransitionPage(
              name: TagsPage.name,
              child: const TagsPage(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) =>
                  FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
            routes: [
              GoRoute(
                path: TagDetailsPage.path,
                name: TagDetailsPage.name,
                pageBuilder: (context, state) => CustomTransitionPage(
                  name: TagDetailsPage.name,
                  child: const TagDetailsPage(),
                  transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ) =>
                      FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            path: SettingsPage.path,
            name: SettingsPage.name,
            pageBuilder: (context, state) => CustomTransitionPage(
              name: SettingsPage.name,
              child: const SettingsPage(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) =>
                  FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: ContactUsPage.path,
            name: ContactUsPage.name,
            pageBuilder: (context, state) => CustomTransitionPage(
              name: ContactUsPage.name,
              child: const ContactUsPage(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) =>
                  FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: ExtensionPage.path,
            name: ExtensionPage.name,
            pageBuilder: (context, state) => CustomTransitionPage(
              name: ExtensionPage.name,
              child: const ExtensionPage(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) =>
                  FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            path: DonationsPage.path,
            name: DonationsPage.name,
            pageBuilder: (context, state) => CustomTransitionPage(
              name: DonationsPage.name,
              child: const DonationsPage(),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) =>
                  FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final go = _ref.watch(afterAuthProvider).value;
      if (go != state.matchedLocation &&
          _specials.contains(state.matchedLocation)) {
        return go;
      }
      return null;
    },
  );
}
