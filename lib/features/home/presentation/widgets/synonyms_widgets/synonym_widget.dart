import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/router/word_navigator_observer.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/pages/view_word_page.dart';
import 'package:lexisnap/features/home/presentation/widgets/synonyms_widgets/selected_synonyms_provider.dart';

class SynonymWidget extends ConsumerWidget {
  final MinimalWord synonym;
  final bool fromDialog;
  const SynonymWidget({
    super.key,
    required this.synonym,
    this.fromDialog = false,
  });

  static const _greenGradient = LinearGradient(
    colors: [
      AppColors.green,
      Color.fromRGBO(121, 196, 126, 0.5),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const _whiteGradient = LinearGradient(
    colors: [
      AppColors.white,
      Color.fromRGBO(255, 255, 255, 0.75),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedSynonymsProvider).contains(synonym);
    return GestureDetector(
      onTap: fromDialog ? () => select(ref, selected) : () => navigate(context, ref, synonym.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          gradient: _getGradient(selected),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: AppText(
          text: synonym.word,
          fontSize: 14,
          color: AppColors.scaffoldBackgroundColor,
        ),
      ),
    );
  }

  Gradient _getGradient(bool selected) {
    if (fromDialog) {
      if (selected) {
        return _greenGradient;
      } else {
        return _whiteGradient;
      }
    } else {
      return _greenGradient;
    }
  }

  void select(WidgetRef ref, bool selected) {
    if (selected) {
      ref.read(selectedSynonymsProvider.notifier).removeSynonym(synonym);
    } else {
      ref.read(selectedSynonymsProvider.notifier).addSynonym(synonym);
    }
  }

  void navigate(BuildContext context, WidgetRef ref, String id) {
    final oldWordId = ref.read(wordProvider)!.id;
    final word = ref.read(allWordsProvider).firstWhere((w) => w.id == id, orElse: () => const Word.empty());
    if (word.isEmpty) {
      showSnackBar(context, 'This word no longer exists, it may have been removed.');
      return;
    }
    ref.read(wordPagesStackProvider.notifier).update((state) => [...state, oldWordId]);
    Future.delayed(Duration.zero, () {
      ref.read(wordProvider.notifier).updateWordObject(word.copyWith());
    });
    GoRouter.of(context).pushNamed(ViewWordPage.name);
  }
}
