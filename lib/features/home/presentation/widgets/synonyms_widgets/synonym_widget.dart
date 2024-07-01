import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/presentation/widgets/synonyms_widgets/selected_synonyms_provider.dart';

class SynonymWidget extends ConsumerWidget {
  final MinimalWord synonym;
  final bool fromDialog;
  const SynonymWidget({
    super.key,
    required this.synonym,
    this.fromDialog = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedSynonymsProvider).contains(synonym);
    return GestureDetector(
      onTap: fromDialog ? () => select(ref, selected) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          gradient: selected
              ? const LinearGradient(
                  colors: [
                    AppColors.green,
                    Color.fromRGBO(121, 196, 126, 0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [
                    AppColors.white,
                    Color.fromRGBO(255, 255, 255, 0.75),
                  ],
                ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Text(
          synonym.word,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }

  void select(WidgetRef ref, bool selected) {
    if (selected) {
      ref.read(selectedSynonymsProvider.notifier).removeSynonym(synonym);
    } else {
      ref.read(selectedSynonymsProvider.notifier).addSynonym(synonym);
    }
  }
}
