import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/app/app.dart';
import 'package:lexisnap/core/shared/shared_preferences_manager.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/core/config/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(
    ProviderScope(
      overrides: [
        sharedPrefProvider.overrideWithValue(
          SharedPreferencesManager(
            sharedPreferences: await SharedPreferences.getInstance(),
          ),
        ),
      ],
      child: const App(),
    ),
  );
  setSystemUIStyle();
}
