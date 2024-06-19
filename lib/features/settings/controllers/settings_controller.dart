import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/shared_preferences_manager.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';

final settingsControllerProvider = Provider<SettingsController>(
  (ref) => SettingsController(ref: ref),
);

class SettingsController {
  final Ref _ref;
  const SettingsController({
    required Ref ref,
  }) : _ref = ref;

  Future<void> setSpeechRate(BuildContext context, double rate) async {
    final success = await _ref.read(sharedPrefProvider).setSpeechRate(rate);
    if (!success) {
      Future.delayed(Duration.zero, () {
        showSnackBar(context, 'Error while changing the speed rate, try again!');
      });
    }
  }

  Future<void> setSpeechPitch(BuildContext context, double pitch) async {
    final success = await _ref.read(sharedPrefProvider).setSpeechPitch(pitch);
    if (!success) {
      Future.delayed(Duration.zero, () {
        showSnackBar(context, 'Error while changing the pitch, try again!');
      });
    }
  }

  Future<void> setSpeechLanguage(BuildContext context, String language) async {
    final success = await _ref.read(sharedPrefProvider).setSpeechLanguage(language);
    if (!success) {
      Future.delayed(Duration.zero, () {
        showSnackBar(context, 'Error while changing the language, try again!');
      });
    }
  }

  double getSpeechRate() {
    return _ref.read(sharedPrefProvider).getSpeechRate();
  }

  double getSpeechPitch() {
    return _ref.read(sharedPrefProvider).getSpeechPitch();
  }

  String getSpeechLanguage() {
    return _ref.read(sharedPrefProvider).getSpeechLanguage();
  }
}
