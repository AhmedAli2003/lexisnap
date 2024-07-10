import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
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
      Color.fromRGBO(244, 67, 54, 0.5),
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
      onTap: fromDialog ? () => select(ref, selected) : navigate,
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

  void navigate() {
    //TODO: navigate to the word page
  }
}
