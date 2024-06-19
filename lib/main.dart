import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/app/app.dart';
import 'package:lexisnap/core/shared/initialize_tts.dart';
import 'package:lexisnap/core/shared/shared_preferences_manager.dart';
import 'package:lexisnap/core/shared/tts_provider.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/core/config/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Ensure Flutter Binding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await initializeFirebase();

  // Get Shared Preference instance to inject it into the provider
  // and to use it to initialize the FlutterTts Object
  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize the FlutterTts
  final tts = await initializeTts(sharedPreferences);

  // Run the app
  runApp(
    ProviderScope(
      overrides: [
        // Override shared preferences provider
        sharedPrefProvider.overrideWithValue(
          SharedPreferencesManager(
            sharedPreferences: sharedPreferences,
          ),
        ),
        // Override Tts provider
        ttsProvider.overrideWith(
          (ref) => TtsHandler(
            ref: ref,
            tts: tts,
          ),
        ),
      ],
      child: const App(),
    ),
  );

  // Set the system UI overlay style
  setSystemUIStyle(Brightness.light);
}
