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

  Future<bool> saveAccessToken(String accessToken) async {
    return await _sharedPreferences.setString('ACCESS_TOKEN', accessToken);
  }

  String getAccessToken() {
    final accessToken = _sharedPreferences.getString('ACCESS_TOKEN');
    if (accessToken == null) {
      //TODO: You must sign in
      throw Exception();
    }
    return accessToken;
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
}
