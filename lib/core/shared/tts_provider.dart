import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:lexisnap/core/shared/shared_preferences_manager.dart';
import 'package:lexisnap/core/shared/string_utils.dart';

class UtteranceState {
  final String id;
  final bool speak;

  const UtteranceState({
    required this.id,
    required this.speak,
  });

  const UtteranceState.starter({
    this.id = '',
    this.speak = false,
  });

  UtteranceState copyWith({
    String? id,
    bool? speak,
  }) {
    return UtteranceState(
      id: id ?? this.id,
      speak: speak ?? this.speak,
    );
  }

  @override
  String toString() => 'UtteranceState(id: $id, speak: $speak)';

  @override
  bool operator ==(covariant UtteranceState other) {
    if (identical(this, other)) return true;

    return other.id == id && other.speak == speak;
  }

  @override
  int get hashCode => id.hashCode ^ speak.hashCode;
}

final ttsProvider = StateNotifierProvider<TtsHandler, UtteranceState>(
  (ref) => throw UnimplementedError(),
);

class TtsHandler extends StateNotifier<UtteranceState> {
  final Ref _ref;
  final FlutterTts _tts;
  TtsHandler({
    required Ref ref,
    required FlutterTts tts,
  })  : _ref = ref,
        _tts = tts,
        super(const UtteranceState.starter()) {
    _tts.setCompletionHandler(() {
      state = const UtteranceState.starter();
    });
  }

  Future<void> speak({
    required String text,
    required String id,
    double? speed,
    double? pitch,
  }) async {
    await stop();
    state = UtteranceState(id: id, speak: true);

    final sharedPrefs = _ref.read(sharedPrefProvider);
    final currentSpeed = sharedPrefs.getSpeechRate();
    final currentPitch = sharedPrefs.getSpeechPitch();

    // Update speed if different
    if (speed != null && speed != currentSpeed) {
      await _tts.setSpeechRate(speed);
    } else {
      await _tts.setSpeechRate(currentSpeed);
    }

    // Update pitch if different
    if (pitch != null && pitch != currentPitch) {
      await _tts.setPitch(pitch);
    } else {
      await _tts.setPitch(currentPitch);
    }
    await _tts.speak(StringUtils.removeSpecialCharacters(text));
  }

  Future<void> stop() async {
    await _tts.stop();
    state = const UtteranceState.starter();
  }
}
