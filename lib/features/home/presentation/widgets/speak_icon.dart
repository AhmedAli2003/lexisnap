import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/logic.dart';
import 'package:lexisnap/core/shared/tts_provider.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/settings/controllers/settings_controller.dart';

class SpeakIcon extends ConsumerStatefulWidget {
  final String text;
  final String id;
  final double size;
  const SpeakIcon({
    super.key,
    required this.text,
    required this.id,
    this.size = 30,
  });

  @override
  ConsumerState<SpeakIcon> createState() => _SpeakIconState();
}

class _SpeakIconState extends ConsumerState<SpeakIcon> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  late double currentSpeed;

  @override
  void initState() {
    super.initState();
    currentSpeed = ref.read(settingsControllerProvider).getSpeechRate();
  }

  @override
  Widget build(BuildContext context) {
    final utteranceState = ref.watch(ttsProvider);
    final speaking = utteranceState.speak && utteranceState.id == widget.id;
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        onTap: () => speaking
            ? _stop(ref: ref)
            : _speak(
                ref: ref,
                text: widget.text,
                rate: convertSpeedToRate(currentSpeed),
                pitch: ref.read(settingsControllerProvider).getSpeechPitch(),
              ),
        onLongPress: _showOverlay,
        child: Container(
          padding: const EdgeInsets.all(4),
          child: speaking
              ? Icon(
                  Icons.mic_off_rounded,
                  color: AppColors.white,
                  size: widget.size,
                )
              : Icon(
                  Icons.mic_rounded,
                  color: AppColors.white,
                  size: widget.size,
                ),
        ),
      ),
    );
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: 200,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(-200, -50),
            child: Material(
              elevation: 4.0,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.deepPurple,
                          Colors.deepPurpleAccent,
                          Color.fromARGB(255, 171, 151, 226),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const AppText(
                          text: 'Adjust Speech Speed',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                        Slider.adaptive(
                          value: currentSpeed,
                          min: 0.5,
                          max: 2.0,
                          activeColor: AppColors.blue,
                          divisions: 6,
                          label: currentSpeed.toStringAsFixed(2),
                          onChanged: (value) {
                            setState(() {
                              currentSpeed = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: -10,
                    child: IconButton(
                      onPressed: _removeOverlay,
                      icon: const Icon(
                        Icons.check_rounded,
                        color: Color.fromARGB(255, 5, 238, 21),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _speak({
    required WidgetRef ref,
    required String text,
    required double rate,
    required double pitch,
  }) {
    ref.read(ttsProvider.notifier).speak(
          text: text,
          id: widget.id,
          pitch: pitch,
          speed: rate,
        );
  }

  void _stop({
    required WidgetRef ref,
  }) {
    ref.read(ttsProvider.notifier).stop();
  }
}
