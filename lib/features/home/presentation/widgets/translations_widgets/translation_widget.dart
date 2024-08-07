import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/selected_translations_provider.dart';

class TranslationWidget extends ConsumerWidget {
  final String translation;
  final bool fromView;

  const TranslationWidget({
    super.key,
    required this.translation,
    this.fromView = false,
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
        onTap: fromView ? () {} : () => onTap(ref, selected),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: selected ? Border.all(color: AppColors.blue, width: 1.0) : null,
            gradient: const LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.deepPurpleAccent,
                Color.fromARGB(255, 171, 151, 226),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppText(
            text: translation,
            textDirection: TextDirection.rtl,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
