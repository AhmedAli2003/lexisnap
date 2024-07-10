import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/shared_preferences_manager.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/core/theme/text-styles/delius.dart';
import 'package:lexisnap/core/theme/text-styles/lato.dart';
import 'package:lexisnap/core/theme/text-styles/merriweather.dart';
import 'package:lexisnap/core/theme/text-styles/montserrat.dart';
import 'package:lexisnap/core/theme/text-styles/nunito.dart';
import 'package:lexisnap/core/theme/text-styles/open_sans.dart';
import 'package:lexisnap/core/theme/text-styles/pacifico.dart';
import 'package:lexisnap/core/theme/text-styles/playfair_display.dart';
import 'package:lexisnap/core/theme/text-styles/poppins.dart';
import 'package:lexisnap/core/theme/text-styles/roboto.dart';
import 'package:lexisnap/features/settings/controllers/text_families.dart';

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

  Future<void> setTextFamily({required BuildContext context, required TextFamily textFamily}) async {
    final success = await _ref.read(sharedPrefProvider).setTextFamily(textFamily.name);
    if (!success) {
      showSnackBar(context, 'Error while changing the pitch, try again!');
    }
  }

  TextFamily getTextFamily() {
    final textFamily = _ref.read(sharedPrefProvider).getTextFamily();
    return TextFamily.values.firstWhere((t) => t.name == textFamily);
  }

  TextStyle getTextStyle({
    double fontSize = 16,
    Color? color,
    FontWeight? fontWeight,
    double? wordSpacing,
    double? letterSpacing,
  }) {
    final textFamily = getTextFamily();
    switch (textFamily) {
      case TextFamily.lato:
        return lato(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing,
        );
      case TextFamily.delius:
        return delius(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing,
        );
      case TextFamily.merriweather:
        return merriweather(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing,
        );
      case TextFamily.montserrat:
        return montserrat(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing,
        );
      case TextFamily.nunito:
        return nunito(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing,
        );
      case TextFamily.openSans:
        return openSans(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing,
        );
      case TextFamily.pacifico:
        return pacifico(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing,
        );
      case TextFamily.playfairDisplay:
        return playfairDisplay(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing,
        );
      case TextFamily.poppins:
        return poppins(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing,
        );
      case TextFamily.roboto:
        return roboto(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          wordSpacing: wordSpacing,
          letterSpacing: letterSpacing,
        );
    }
  }
}
