// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:lexisnap/core/models/create_word_request.dart';
import 'package:lexisnap/core/models/update_word_request.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/features/home/data/repositories/word_repository_impl.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';
import 'package:lexisnap/features/home/domain/repositories/word_repository.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';

final wordsOverviewProvider = StateProvider<List<MinimalWord>>((_) => []);

final allWordsProvider = StateProvider<List<Word>>((_) => []);

final wordProvider = StateNotifierProvider.autoDispose<WordNotifier, Word?>((_) => WordNotifier(null));

class WordNotifier extends StateNotifier<Word?> {
  WordNotifier(super.state);

  void updateState(Word? word) {
    state = word;
  }

  void updateWord(String word) {
    if (state == null) {
      throw Exception();
    }
    state = state!.copyWith(word: word);
  }

  void addTranslation(String translation) {
    if (state == null) {
      throw Exception();
    }
    state = state!.copyWith(translations: [...state!.translations, translation]);
  }

  void deleteTranslation(String translation) {
    if (state == null) {
      throw Exception();
    }
    List<String> translations = state!.translations;
    translations = translations.delete(translation).toList();
    state = state!.copyWith(translations: translations);
  }

  void deleteManyTranslations(List<String> translationsToDelete) {
    if (state == null) {
      throw Exception();
    }
    final newTranslations = [...state!.translations];
    newTranslations.removeWhere((t) => translationsToDelete.contains(t));
    state = state!.copyWith(translations: newTranslations);
  }

  void addDefinition(String definition) {
    if (state == null) {
      throw Exception();
    }
    state = state!.copyWith(definitions: [...state!.definitions, definition]);
  }

  void updateOneDifinition(String oldDefinition, String newDefinition) {
    if (state == null) {
      throw Exception();
    }
    final definitions = [...state!.definitions];
    final index = definitions.indexOf(oldDefinition);
    definitions.removeAt(index);
    definitions.insert(index, newDefinition);
    state = state!.copyWith(definitions: definitions);
  }

  void deleteDifinition(String definition) {
    if (state == null) {
      throw Exception();
    }
    List<String> definitions = state!.definitions;
    definitions = definitions.delete(definition).toList();
    state = state!.copyWith(definitions: definitions);
  }

  void addStatement(Statement statement) {
    if (state == null) {
      throw Exception();
    }
    state = state!.copyWith(statements: [...state!.statements, statement]);
  }

  void updateStatement(Statement statement) {
    if (state == null) {
      throw Exception();
    }
    final index = state!.statements.indexOf(statement);
    final newStatements = [...state!.statements];
    final oldStatement = newStatements.removeAt(index);
    newStatements.insert(
      index,
      oldStatement.copyWith(
        text: statement.text,
        translation: statement.translation,
      ),
    );
    state = state!.copyWith(statements: newStatements);
  }

  void deleteStatement(Statement statement) {}

  void addTag(MinimalTag tag) {
    if (state == null) {
      throw Exception();
    }
    state = state!.copyWith(tags: [...state!.tags, tag]);
  }

  void deleteTag(MinimalTag tag) {
    if (state == null) {
      throw Exception();
    }
    List<MinimalTag> tags = state!.tags;
    tags = tags.delete(tag).toList();
    state = state!.copyWith(tags: tags);
  }
}

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

  void getWordById(BuildContext context, String id) async {
    state = state.copyWith(getWordById: true);
    final either = await _repository.getWordById(id);
    state = state.copyWith(getWordById: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (word) => _ref.read(wordProvider.notifier).updateState(word),
    );
  }

  void createWord(BuildContext context, CreateWordRequest word) async {
    state = state.copyWith(createWord: true);
    final either = await _repository.createWord(word);
    state = state.copyWith(createWord: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (word) => _ref.read(wordProvider.notifier).updateState(word),
    );
  }

  void updateWord({required BuildContext context, required String id, required UpdateWordRequest word}) async {
    state = state.copyWith(updateWord: true);
    final either = await _repository.updateWord(id, word);
    state = state.copyWith(updateWord: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (word) => _ref.read(wordProvider.notifier).updateState(word),
    );
  }

  void deleteWord(BuildContext context, String id) async {
    state = state.copyWith(deleteWord: true);
    final either = await _repository.deleteWord(id);
    state = state.copyWith(deleteWord: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (word) => _ref.read(wordProvider.notifier).updateState(null),
    );
  }
}

class WordLoadingState {
  final bool getWordsOverview;
  final bool getAllWords;
  final bool getWordById;
  final bool createWord;
  final bool updateWord;
  final bool deleteWord;

  const WordLoadingState({
    this.getWordsOverview = false,
    this.getAllWords = false,
    this.getWordById = false,
    this.createWord = false,
    this.updateWord = false,
    this.deleteWord = false,
  });

  WordLoadingState copyWith({
    bool? getWordsOverview,
    bool? getAllWords,
    bool? getWordById,
    bool? createWord,
    bool? updateWord,
    bool? deleteWord,
  }) {
    return WordLoadingState(
      getWordsOverview: getWordsOverview ?? this.getWordsOverview,
      getAllWords: getAllWords ?? this.getAllWords,
      getWordById: getWordById ?? this.getWordById,
      createWord: createWord ?? this.createWord,
      updateWord: updateWord ?? this.updateWord,
      deleteWord: deleteWord ?? this.deleteWord,
    );
  }
}
