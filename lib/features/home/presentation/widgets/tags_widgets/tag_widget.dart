import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/presentation/widgets/tags_widgets/selected_tags_provider.dart';

class TagWidget extends ConsumerWidget {
  final MinimalTag tag;
  final bool fromDialig;
  const TagWidget({
    super.key,
    required this.tag,
    this.fromDialig = false,
  });

  static const _pinkGradient = LinearGradient(
    colors: [
      AppColors.pink,
      Color.fromRGBO(255, 166, 201, 0.5),
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
    final selected = ref.watch(selectedTagsProvider).contains(tag);
    return GestureDetector(
      onTap: fromDialig ? () => select(ref, selected) : navigate,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          gradient: _getGradient(selected),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: AppText(
          text: '#${tag.name}',
          fontSize: 14,
          color: AppColors.scaffoldBackgroundColor,
        ),
      ),
    );
  }

  Gradient _getGradient(bool selected) {
    if (fromDialig) {
      if (selected) {
        return _pinkGradient;
      } else {
        return _whiteGradient;
      }
    } else {
      return _pinkGradient;
    }
  }

  void select(WidgetRef ref, bool selected) {
    if (selected) {
      ref.read(selectedTagsProvider.notifier).removeTag(tag);
    } else {
      ref.read(selectedTagsProvider.notifier).addTag(tag);
    }
  }

  void navigate() {
    // TODO: navigate to tag widget
  }
}
