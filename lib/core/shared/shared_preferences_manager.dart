import 'package:lexisnap/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sharedPrefProvider = Provider<SharedPreferencesManager>(
  (ref) => throw UnimplementedError(),
);

class SharedPreferencesManager {
  final SharedPreferences _sharedPreferences;

  const SharedPreferencesManager({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  Future<bool> setSpeechRate(double rate) async {
    return await _sharedPreferences.setDouble(AppConstants.speechRateKey, rate);
  }

  double getSpeechRate() {
    return _sharedPreferences.getDouble(AppConstants.speechRateKey) ?? AppConstants.defaultSpeechRate;
  }

  Future<bool> setSpeechPitch(double pitch) async {
    return await _sharedPreferences.setDouble(AppConstants.speechPitchKey, pitch);
  }

  double getSpeechPitch() {
    return _sharedPreferences.getDouble(AppConstants.speechPitchKey) ?? AppConstants.defaultSpeechPitch;
  }

  Future<bool> setSpeechLanguage(String language) async {
    return await _sharedPreferences.setString(AppConstants.speechLanguageKey, language);
  }

  String getSpeechLanguage() {
    return _sharedPreferences.getString(AppConstants.speechLanguageKey) ?? AppConstants.defaultLanguage;
  }

  Future<bool> saveAccessToken(String accessToken) async {
    return await _sharedPreferences.setString('ACCESS_TOKEN', accessToken);
  }

  String getAccessToken() {
    return 'Bearer ${_sharedPreferences.getString('ACCESS_TOKEN')}';
  }

  Future<bool> saveExpirationDate(String expiredIn) async {
    final days = int.parse(expiredIn.replaceAll('d', ''));
    // Calculate the target date
    final currentDate = DateTime.now();
    final targetDate = currentDate.add(Duration(days: days));
    // Save the target date in shared preferences as an integer timestamp
    return await _sharedPreferences.setInt('EXPIRATION_DATE', targetDate.millisecondsSinceEpoch);
  }

  int getExpirationRemainingDays() {
    final targetDateMillis = _sharedPreferences.getInt('EXPIRATION_DATE') ?? 0;
    // Parse the target date from the stored timestamp
    final targetDate = DateTime.fromMillisecondsSinceEpoch(targetDateMillis);

    // Calculate the remaining days
    final currentDate = DateTime.now();
    final difference = targetDate.difference(currentDate).inDays;

    return difference;
  }

  Future<bool> setTextFamily(String textFamily) async {
    return await _sharedPreferences.setString(AppConstants.textFamilyKey, textFamily);
  }

  String getTextFamily() {
    return _sharedPreferences.getString(AppConstants.textFamilyKey) ?? AppConstants.defaultTextFamily;
  }
}
