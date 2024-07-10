import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';

class TagWordsCount extends ConsumerWidget {
  final String tagId;
  const TagWordsCount({
    super.key,
    required this.tagId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allWords = ref.watch(allWordsProvider);
    return FutureBuilder(
      future: () async {
        return Future.delayed(Duration.zero, () {
          int count = 0;

          for (final word in allWords) {
            for (final tag in word.tags) {
              if (tag.id == tagId) {
                count++;
                break;
              }
            }
          }

          return count;
        });
      }(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final count = snapshot.data!;
          if (count == 0) {
            return const AppText(text: 'Empty');
          } else if (count == 1) {
            return const AppText(text: '1 word');
          }
          return AppText(text: '$count words');
        } else {
          return const SizedBox(height: 64, width: 64, child: Loading());
        }
      },
    );
  }
}
