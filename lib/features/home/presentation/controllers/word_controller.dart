import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/models/create_word_request.dart';
import 'package:lexisnap/core/models/update_word_request.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/features/home/data/repositories/word_repository_impl.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';
import 'package:lexisnap/features/home/domain/repositories/word_repository.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller_loading_state.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';

final wordsOverviewProvider = StateProvider<List<MinimalWord>>((_) => []);

final searchWordsProvider = StateProvider.autoDispose.family<List<MinimalWord>, String?>(
  (ref, search) {
    final words = ref.watch(wordsOverviewProvider);
    if (search == null || search.isEmpty) {
      return words.length > 50 ? words.sublist(0, 50) : words;
    }
    return words
        .where(
          (word) => word.word.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();
  },
);

final allWordsProvider = StateProvider<List<Word>>((_) => []);

final wordControllerProvider = StateNotifierProvider<WordController, WordLoadingState>(
  (ref) => WordController(
    ref: ref,
    repository: ref.read(wordRepositoryProvider),
  ),
);

class WordController extends StateNotifier<WordLoadingState> {
  WordController({
    required Ref ref,
    required WordRepository repository,
  })  : _ref = ref,
        _repository = repository,
        super(const WordLoadingState());

  final Ref _ref;
  final WordRepository _repository;

  Future<void> getWordsOverview(BuildContext context) async {
    state = state.copyWith(getWordsOverview: true);
    final either = await _repository.getWordsOverview();
    state = state.copyWith(getWordsOverview: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (words) => _ref.read(wordsOverviewProvider.notifier).update((state) {
        words.sort((a, b) => a.compareTo(b));
        return words;
      }),
    );
  }

  Future<void> getAllWords(BuildContext context, int page) async {
    state = state.copyWith(getAllWords: true);
    final either = await _repository.getAllWords(page: page);
    state = state.copyWith(getAllWords: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (words) => _ref.read(allWordsProvider.notifier).update((state) {
        state.addAll(words);
        return state;
      }),
    );
  }

  Future<Word?> getWordById(BuildContext context, String id) async {
    state = state.copyWith(getWordById: true);
    final either = await _repository.getWordById(id);
    state = state.copyWith(getWordById: false);
    return either.fold(
      (failure) {
        showSnackBar(context, failure.message);
        return null;
      },
      (word) {
        _ref.read(wordProvider.notifier).updateWordObject(word);
        return word;
      },
    );
  }

  Future<Word?> createWord(BuildContext context, CreateWordRequest word) async {
    state = state.copyWith(createWord: true);
    final either = await _repository.createWord(word);
    state = state.copyWith(createWord: false);
    return either.fold(
      (failure) {
        showSnackBar(context, failure.message);
        return null;
      },
      (word) {
        _ref.read(wordProvider.notifier).updateWordObject(word);
        return word;
      },
    );
  }

  Future<Word?> updateWord({
    required BuildContext context,
    required String id,
    required UpdateWordRequest word,
  }) async {
    state = state.copyWith(updateWord: true);
    final either = await _repository.updateWord(id, word);
    state = state.copyWith(updateWord: false);
    return either.fold(
      (failure) {
        showSnackBar(context, failure.message);
        return null;
      },
      (word) {
        _ref.read(wordProvider.notifier).updateWordObject(word);
        return word;
      },
    );
  }

  Future<void> deleteWord(BuildContext context, String id) async {
    state = state.copyWith(deleteWord: true);
    final either = await _repository.deleteWord(id);
    state = state.copyWith(deleteWord: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (word) => _ref.read(wordProvider.notifier).updateWordObject(null),
    );
  }
}
