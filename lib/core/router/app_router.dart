import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/app/app.dart';
import 'package:lexisnap/core/shared/splash_screen.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lexisnap/features/auth/presentation/pages/auth_page.dart';

final routerProvider = Provider<AppRouter>((ref) => AppRouter(ref: ref));

class AppRouter {
  final Ref _ref;

  AppRouter({required Ref ref}) : _ref = ref;

  GoRouter get router => _router;

  late final _router = GoRouter(
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
      ),
    ],
    redirect: (context, state) {
      final go = _ref.watch(afterAuthProvider).value;
      if (go != state.matchedLocation) {
        return go;
      }
      return null;
    },
  );
}
