import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/settings/controllers/settings_controller.dart';

enum HintStyle {
  small,
  medium,
  large,
}

class CustomTextField extends ConsumerWidget {
  final String? hint;
  final TextEditingController? controller;
  final VoidCallback? onEditingComplete;
  final void Function(String text)? onChanged;
  final FocusNode? focusNode;
  final bool? enabled;
  final HintStyle hintStyle;
  final TextDirection? textDirection;
  final Widget? prefixIcon;
  const CustomTextField(
      {super.key,
      this.controller,
      this.onEditingComplete,
      this.focusNode,
      this.hint,
      this.enabled,
      this.hintStyle = HintStyle.large,
      this.textDirection,
      this.onChanged,
      this.prefixIcon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = ref.watch(settingsControllerProvider).getTextStyle;

    return TextField(
      textDirection: textDirection,
      focusNode: focusNode,
      cursorColor: AppColors.blue,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hint,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      enabled: enabled,
      style: hintStyle == HintStyle.large
          ? textStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )
          : textStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
    );
  }
}
