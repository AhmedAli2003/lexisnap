import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/pages/view_word_page.dart';
import 'package:lexisnap/features/home/presentation/widgets/opposites_widgets/selected_opposites_provider.dart';

class OppositeWidget extends ConsumerWidget {
  final MinimalWord opposite;
  final bool fromDialog;
  const OppositeWidget({
    super.key,
    required this.opposite,
    this.fromDialog = false,
  });

  static const _refGradient = LinearGradient(
    colors: [
      Colors.red,
      Color.fromARGB(255, 240, 124, 115),
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
    final selected = ref.watch(selectedOppositesProvider).contains(opposite);
    return GestureDetector(
      onTap: fromDialog ? () => select(ref, selected) : () => navigate(context, ref, opposite.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          gradient: _getGradient(selected),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: AppText(
          text: opposite.word,
          fontSize: 14,
          color: AppColors.scaffoldBackgroundColor,
        ),
      ),
    );
  }

  Gradient _getGradient(bool selected) {
    if (fromDialog) {
      if (selected) {
        return _refGradient;
      } else {
        return _whiteGradient;
      }
    } else {
      return _refGradient;
    }
  }

  void select(WidgetRef ref, bool selected) {
    if (selected) {
      ref.read(selectedOppositesProvider.notifier).removeOpposite(opposite);
    } else {
      ref.read(selectedOppositesProvider.notifier).addOpposite(opposite);
    }
  }

  void navigate(BuildContext context, WidgetRef ref, String id) {
    final word = ref.read(allWordsProvider).firstWhere((w) => w.id == id, orElse: () => const Word.empty());
    if (word.isEmpty) {
      showSnackBar(context, 'This word no longer exists, it may have been removed.');
      return;
    }
    Future.delayed(Duration.zero, () {
      ref.read(wordProvider.notifier).updateWordObject(word.copyWith());
    });
    GoRouter.of(context).goNamed(ViewWordPage.name);
  }
}
