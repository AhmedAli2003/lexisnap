import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/settings/controllers/settings_controller.dart';
import 'package:lexisnap/features/settings/pages/settings_page.dart';

class ErrorText extends StatelessWidget {
  final String text;
  const ErrorText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.red,
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final Color color;
  const Loading({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}

class LoadingScaffold extends StatelessWidget {
  const LoadingScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Loading(),
    );
  }
}

class AppText extends ConsumerWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? wordSpacing;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final int? maxLines;
  final TextOverflow? overflow;
  const AppText({
    super.key,
    required this.text,
    this.color,
    this.fontSize = 16,
    this.fontWeight,
    this.wordSpacing,
    this.letterSpacing,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fontFamilyProvider);
    return Text(
      text,
      style: ref.read(settingsControllerProvider).getTextStyle(
            color: color,
            fontSize: fontSize ?? 16,
            fontWeight: fontWeight,
            wordSpacing: wordSpacing,
            letterSpacing: letterSpacing,
          ),
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

class AppSelectableText extends ConsumerWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final FontWeight? fontWeight;
  final double? wordSpacing;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final int? maxLines;
  const AppSelectableText({
    super.key,
    required this.text,
    this.color,
    this.fontSize = 16,
    this.fontWeight,
    this.wordSpacing,
    this.letterSpacing,
    this.textAlign,
    this.textDirection,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fontFamilyProvider);
    return SelectableText(
      text,
      style: ref.read(settingsControllerProvider).getTextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            wordSpacing: wordSpacing,
            letterSpacing: letterSpacing,
          ),
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    required this.text,
    required this.gradient,
    this.fontSize,
    this.fontWeight,
    this.wordSpacing,
    this.letterSpacing,
    this.textAlign,
    this.textDirection,
    this.maxLines,
    this.overflow,
  });
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? wordSpacing;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final int? maxLines;
  final TextOverflow? overflow;
  final Gradient gradient;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: AppText(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        textDirection: textDirection,
        wordSpacing: wordSpacing,
      ),
    );
  }
}
