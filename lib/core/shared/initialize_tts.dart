import 'package:flutter_tts/flutter_tts.dart';
import 'package:lexisnap/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<FlutterTts> initializeTts(SharedPreferences prefs) async {
  final tts = FlutterTts();

  final condition = !prefs.containsKey(AppConstants.speechRateKey) ||
      !prefs.containsKey(AppConstants.speechPitchKey) ||
      !prefs.containsKey(AppConstants.speechLanguageKey);

  if (condition) {
    await prefs.setDouble(AppConstants.speechRateKey, AppConstants.defaultSpeechRate);
    await prefs.setDouble(AppConstants.speechPitchKey, AppConstants.defaultSpeechPitch);
    await prefs.setString(AppConstants.speechLanguageKey, AppConstants.defaultLanguage);
  }

  await tts.setLanguage(prefs.getString(AppConstants.speechLanguageKey) ?? AppConstants.defaultLanguage);
  await tts.setPitch(prefs.getDouble(AppConstants.speechPitchKey) ?? AppConstants.defaultSpeechPitch);
  await tts.setSpeechRate(prefs.getDouble(AppConstants.speechRateKey) ?? AppConstants.defaultSpeechRate);

  return tts;
}
