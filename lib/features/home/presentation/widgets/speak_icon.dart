import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/logic.dart';
import 'package:lexisnap/core/shared/tts_provider.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/settings/controllers/settings_controller.dart';

class SpeakIcon extends ConsumerWidget {
  final String text;
  final double size;
  const SpeakIcon({
    super.key,
    required this.text,
    this.size = 30,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speaking = ref.watch(ttsProvider);
    return IconButton(
      iconSize: size,
      padding: EdgeInsets.zero,
      onPressed: () => speaking
          ? _stop(ref: ref)
          : _speak(
              ref: ref,
              text: text,
              rate: convertSpeedToRate(ref.read(settingsControllerProvider).getSpeechRate()),
              pitch: ref.read(settingsControllerProvider).getSpeechPitch(),
            ),
      icon: Icon(
        Icons.volume_up_rounded,
        color: AppColors.white,
        size: size,
      ),
    );
  }

  void _speak({
    required WidgetRef ref,
    required String text,
    required double rate,
    required double pitch,
  }) {
    ref.read(ttsProvider.notifier).speak(text: text, pitch: pitch, speed: rate);
  }

  void _stop({
    required WidgetRef ref,
  }) {
    ref.read(ttsProvider.notifier).stop();
  }
}
