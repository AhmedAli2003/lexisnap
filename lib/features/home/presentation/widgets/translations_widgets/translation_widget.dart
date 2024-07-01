import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/selected_translations_provider.dart';

class TranslationWidget extends ConsumerWidget {
  final String translation;

  const TranslationWidget({
    super.key,
    required this.translation,
  });

  void onTap(WidgetRef ref, bool selected) {
    if (selected) {
      ref.read(selectedTranslationsProvider.notifier).remove(translation);
    } else {
      ref.read(selectedTranslationsProvider.notifier).add(translation);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedTranslationsProvider.notifier).contains(translation);
    return Padding(
      padding: EdgeInsets.all(selected ? 3.0 : 4.0),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        splashColor: AppColors.blue,
        onTap: () => onTap(ref, selected),
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
