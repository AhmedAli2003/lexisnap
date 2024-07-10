import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lexisnap/core/constants/app_constants.dart';
import 'package:lexisnap/core/shared/shared_preferences_manager.dart';
import 'package:lexisnap/core/shared/string_utils.dart';

final ttsProvider = StateNotifierProvider<TtsHandler, bool>(
  (ref) => throw UnimplementedError(),
);

class TtsHandler extends StateNotifier<bool> {
  final Ref _ref;
  final FlutterTts _tts;
  TtsHandler({
    required Ref ref,
    required FlutterTts tts,
  })  : _ref = ref,
        _tts = tts,
        super(false);

  Future<void> speak({
    required String text,
    double speed = AppConstants.defaultSpeechRate,
    double pitch = AppConstants.defaultSpeechPitch,
  }) async {
    state = true;
    if (speed != _ref.read(sharedPrefProvider).getSpeechRate()) {
      await _tts.setSpeechRate(speed);
    }
    if (pitch != _ref.read(sharedPrefProvider).getSpeechPitch()) {
      await _tts.setPitch(pitch);
    }
    await _tts.speak(StringUtils.removeSpecialCharacters(text));
    state = false;
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
