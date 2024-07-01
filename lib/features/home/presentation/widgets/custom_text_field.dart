import 'package:flutter/material.dart';
import 'package:lexisnap/core/theme/app_colors.dart';

enum HintStyle {
  small,
  medium,
  large,
}

class CustomTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final VoidCallback? onEditingComplete;
  final void Function(String text)? onChanged;
  final FocusNode? focusNode;
  final bool? enabled;
  final HintStyle hintStyle;
  final TextDirection? textDirection;
  const CustomTextField({
    super.key,
    this.controller,
    this.onEditingComplete,
    this.focusNode,
    this.hint,
    this.enabled,
    this.hintStyle = HintStyle.large,
    this.textDirection,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textDirection: textDirection,
      focusNode: focusNode,
      cursorColor: AppColors.blue,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      enabled: enabled,
      style: hintStyle == HintStyle.large
          ? const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )
          : const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
    );
  }
}
