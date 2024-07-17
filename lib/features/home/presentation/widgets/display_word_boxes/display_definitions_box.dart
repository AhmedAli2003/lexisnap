import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/string_utils.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/definitions_widgets/definitions_box.dart';

class DisplayDifinitionsBox extends ConsumerWidget {
  const DisplayDifinitionsBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final definitions = ref.watch(wordDefinitionsProvider);
    return definitions.isEmpty
        ? const SizedBox()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const DefinitionsTitle(),
              const SizedBox(height: 12),
              ...definitions.map(
                (definition) => Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 8),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.grey,
                        Color.fromRGBO(39, 41, 48, 0.5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: AppSelectableText(
                    text: StringUtils.capitalize(definition),
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
  }
}
