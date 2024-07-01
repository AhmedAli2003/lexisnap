import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';

final searchControllerProvider = StateNotifierProvider.autoDispose<SearchController, Set<MinimalWord>>(
  (ref) => SearchController(ref),
);

class SearchController extends StateNotifier<Set<MinimalWord>> {
  final Ref _ref;
  SearchController(Ref ref)
      : _ref = ref,
        super(<MinimalWord>{});

  void search(String query) {
    final words = _ref.read(wordsOverviewProvider);
    if (query.isEmpty) {
      state = {};
      return;
    }
    final filteredWords = <MinimalWord>{};
    int counter = 0;
    for (int i = 0; i < words.length && counter < 30; i++) {
      final word = words[i];
      if (word.word.toLowerCase().contains(query.toLowerCase())) {
        counter++;
        filteredWords.add(word);
      }
    }
    state = filteredWords;
  }
}
