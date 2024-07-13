import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/mappers/tag_mappers.dart';
import 'package:lexisnap/features/home/presentation/controllers/tag_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/pages/tag_details_page.dart';
import 'package:lexisnap/features/home/presentation/pages/view_word_page.dart';

final wordPagesStackProvider = StateProvider<List<String>>((ref) => []);

final tagPagesStackProvider = StateProvider<List<String>>((ref) => []);

class WordNavigatorObserver extends NavigatorObserver {
  final Ref ref;

  WordNavigatorObserver(this.ref);

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name == ViewWordPage.name) {
      final id = ref.read(wordPagesStackProvider).lastOrNull;
      if (id == null) {
        return;
      }
      ref.read(wordPagesStackProvider.notifier).update((state) => [...state..removeLast()]);
      final word = ref.read(allWordsProvider).firstWhere((w) => w.id == id);
      ref.read(wordProvider.notifier).updateWordObject(word.copyWith());
    }
    if (route.settings.name == TagDetailsPage.name) {
      final id = ref.read(tagPagesStackProvider).lastOrNull;
      if (id == null) {
        return;
      }
      ref.read(tagPagesStackProvider.notifier).update((state) => [...state..removeLast()]);
      final tag = ref.read(allTagsProvider).firstWhere((t) => t.id == id);
      ref.read(tagProvider.notifier).update((state) => tag.toTag());
    }
  }
}
