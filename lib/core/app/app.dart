import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/router/app_router.dart';
import 'package:lexisnap/core/theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Lexisnap',
      theme: AppTheme.dark,
      routerConfig: ref.watch(routerProvider).router,
    );
  }
}
