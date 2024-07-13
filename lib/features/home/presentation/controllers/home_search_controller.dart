import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';

final homeSearchControllerProvider = StateNotifierProvider.autoDispose<HomeSearchController, List<Word>?>(
  (ref) => HomeSearchController(ref),
);

class HomeSearchController extends StateNotifier<List<Word>?> {
  final Ref _ref;
  HomeSearchController(Ref ref)
      : _ref = ref,
        super(null);

  void search(String query) {
    final words = _ref.read(allWordsProvider);
    if (query.isEmpty) {
      state = [];
      return;
    }
    final filteredWords = <Word>[];
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

  void clear() {
    state = null;
  }
}
