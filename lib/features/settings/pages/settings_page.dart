import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/settings/controllers/settings_controller.dart';

class SettingsPage extends ConsumerWidget {
  static const String path = 'settings';
  static const String name = 'Settings-Page';
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsController = ref.watch(settingsControllerProvider);
    return Scaffold();
  }
}
