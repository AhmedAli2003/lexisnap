import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';
import 'package:lexisnap/features/home/presentation/controllers/home_search_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';

enum Sorting {
  dateAsc,
  dateDesc,
  alphaAsc,
  alphaDesc,
}

final wordsSortingProvider = StateProvider<Sorting>((ref) {
  return Sorting.dateDesc;
});

final homePageWordsProvider = StateNotifierProvider.autoDispose<HomePageWordsNotifier, List<Word>>((ref) {
  ref.watch(wordsSortingProvider);
  final words = ref.watch(allWordsProvider);
  final searchedWords = ref.watch(homeSearchControllerProvider);

  if (searchedWords != null) {
    return HomePageWordsNotifier(ref: ref, words: searchedWords);
  }

  return HomePageWordsNotifier(
    ref: ref,
    words: words,
  )..sort();
});

class HomePageWordsNotifier extends StateNotifier<List<Word>> {
  final Ref _ref;

  HomePageWordsNotifier({
    required Ref ref,
    required List<Word> words,
  })  : _ref = ref,
        super(words);

  void sort() {
    switch (_ref.read(wordsSortingProvider)) {
      case Sorting.dateAsc:
        state = [..._ref.read(allWordsProvider)].reversed.toList();
        break;
      case Sorting.dateDesc:
        state = [..._ref.read(allWordsProvider)];
        break;
      case Sorting.alphaAsc:
        state = [...state]..sort((a, b) => a.compareTo(b));
      case Sorting.alphaDesc:
        state = [...state]..sort((a, b) => b.compareTo(a));
    }
  }
}
