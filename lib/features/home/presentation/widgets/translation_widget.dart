import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/widgets/translation_field_widget.dart';

class TranslationWidget extends ConsumerWidget {
  final String translation;
  final VoidCallback onTap;

  const TranslationWidget({
    super.key,
    required this.translation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedTranslationsProvider).contains(translation);
    return Padding(
      padding: EdgeInsets.all(selected ? 3.0 : 4.0),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        splashColor: AppColors.blue,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: selected ? Border.all(color: AppColors.blue, width: 1.0) : null,
            gradient: const LinearGradient(
              colors: [
                AppColors.purple,
                Color.fromRGBO(123, 100, 223, 0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Text(
            translation,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
