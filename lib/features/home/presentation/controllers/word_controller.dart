import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/data/repositories/word_repository_impl.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';
import 'package:lexisnap/features/home/domain/repositories/word_repository.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';

final wordsOverviewProvider = StateProvider<List<MinimalWord>>((_) => []);

final allWordsProvider = StateProvider<List<Word>>((_) => []);

final wordProvider = StateProvider<Word?>((_) => null);

final wordControllerProvider = Provider<WordController>(
  (ref) => WordController(
    ref: ref,
    repository: ref.read(wordRepositoryProvider),
  ),
);

class WordController extends StateNotifier<WordControllerState> {
  WordController({
    required Ref ref,
    required WordRepository repository,
  })  : _ref = ref,
        _repository = repository,
        super(WordControllerState());

  final Ref _ref;
  final WordRepository _repository;

  void getWordsOverview(BuildContext context) async {
    state.getWordsOverviewLoading = true;
    final either = await _repository.getWordsOverview();
    state.getWordsOverviewLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (words) => _ref.read(wordsOverviewProvider.notifier).update((state) {
        state.addAll(words);
        return state;
      }),
    );
  }

  void getAllWords(BuildContext context, int page) async {
    state.getAllWordsLoading = true;
    final either = await _repository.getAllWords(page: page);
    state.getAllWordsLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (words) => _ref.read(allWordsProvider.notifier).update((state) {
        state.addAll(words);
        return state;
      }),
    );
  }

  void getWordById(BuildContext context, String id) async {
    state.getWordByIdLoading = true;
    final either = await _repository.getWordById(id);
    state.getWordByIdLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (word) => _ref.read(wordProvider.notifier).update((_) => word),
    );
  }

  void updateWord(BuildContext context, Word word) async {
    state.updateWordLoading = true;
    final either = await _repository.updateWord(word);
    state.updateWordLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (word) => _ref.read(wordProvider.notifier).update((_) => word),
    );
  }

  void deleteWord(BuildContext context, String id) async {
    state.deleteWordLoading = true;
    final either = await _repository.deleteWord(id);
    state.deleteWordLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (word) => _ref.read(wordProvider.notifier).update((_) => null),
    );
  }
}

class WordControllerState {
  bool getWordsOverviewLoading;
  bool getAllWordsLoading;
  bool getWordByIdLoading;
  bool updateWordLoading;
  bool deleteWordLoading;

  WordControllerState({
    this.getWordsOverviewLoading = false,
    this.getAllWordsLoading = false,
    this.getWordByIdLoading = false,
    this.updateWordLoading = false,
    this.deleteWordLoading = false,
  });
}
