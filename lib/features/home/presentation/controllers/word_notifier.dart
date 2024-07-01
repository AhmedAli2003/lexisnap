import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier_transaction_result.dart';
import 'package:uuid/uuid.dart';

final wordChangesProvider = StateProvider.autoDispose<bool>((ref) => false);

final wordProvider = StateNotifierProvider<WordNotifier, Word?>(
  (ref) => WordNotifier(
    ref: ref,
    state: null,
  ),
);

final wordTextProvider = Provider.autoDispose<String>((ref) {
  return ref.watch(wordProvider.select((word) => word?.word ?? ''));
});

final wordDefinitionsProvider = Provider.autoDispose<Set<String>>((ref) {
  return ref.read(wordProvider.select((word) => word?.definitions ?? {}));
});

final wordTranslationsProvider = Provider.autoDispose<Set<String>>((ref) {
  return ref.watch(wordProvider.select((word) => {...?word?.translations}));
});

final wordTagsProvider = Provider.autoDispose<Set<MinimalTag>>((ref) {
  return ref.watch(wordProvider.select((word) => {...?word?.tags}));
});

final wordStatementsProvider = Provider.autoDispose<Set<Statement>>((ref) {
  return ref.watch(wordProvider.select((word) => {...?word?.statements}));
});

final wordSynonymsProvider = Provider.autoDispose<Set<MinimalWord>>((ref) {
  return ref.watch(wordProvider.select((word) => {...?word?.synonyms}));
});

final wordOppositesProvider = Provider.autoDispose<Set<MinimalWord>>((ref) {
  return ref.watch(wordProvider.select((word) => {...?word?.opposites}));
});

final wordNoteProvider = Provider.autoDispose<String>((ref) {
  return ref.watch(wordProvider.select((word) => word?.note ?? ''));
});

class WordNotifier extends StateNotifier<Word?> {
  final Ref _ref;
  WordNotifier({
    required Ref ref,
    required Word? state,
  })  : _ref = ref,
        super(state);

  final _uuid = const Uuid();

  String get _generateId => _uuid.v4();

  // Update the state (from null to object or from object to null)
  void updateWordObject(Word? word) {
    state = word;
  }

  WordNotifierTransactionResult updateWordText(String word) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    state = state!.copyWith(word: word);
    _ref.read(wordChangesProvider.notifier).state = true;
    return WordNotifierTransactionResult.success();
  }

  WordNotifierTransactionResult addTranslation(String translation) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    final added = state!.translations.add(translation);
    if (added) {
      state = state!.copyWith(appId: _generateId);
      _ref.read(wordChangesProvider.notifier).state = true;
      return WordNotifierTransactionResult.success();
    }
    return WordNotifierTransactionResult.itemAlreadyExists();
  }

  WordNotifierTransactionResult removeManyTranslations(Set<String> translationsToDelete) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    state!.translations.removeAll(translationsToDelete);
    state = state!.copyWith(appId: _generateId);
    _ref.read(wordChangesProvider.notifier).state = true;
    return WordNotifierTransactionResult.success();
  }

  WordNotifierTransactionResult addDefinition(String definition) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    final added = state!.definitions.add(definition);
    if (added) {
      state = state!.copyWith(appId: _generateId);
      _ref.read(wordChangesProvider.notifier).state = true;
      return WordNotifierTransactionResult.success();
    }
    return WordNotifierTransactionResult.itemAlreadyExists();
  }

  WordNotifierTransactionResult updateOneDifinition(String oldDefinition, String newDefinition) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    // Delete the old definition and add the new definition

    state!.definitions
      ..remove(oldDefinition)
      ..add(newDefinition);
    state = state!.copyWith(appId: _generateId);
    _ref.read(wordChangesProvider.notifier).state = true;
    return WordNotifierTransactionResult.success();
  }

  WordNotifierTransactionResult removeDifinition(String definition) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    final removed = state!.definitions.remove(definition);
    if (removed) {
      state = state!.copyWith(appId: _generateId);
      _ref.read(wordChangesProvider.notifier).state = true;
      return WordNotifierTransactionResult.success();
    }
    return WordNotifierTransactionResult.itemDoesNotExist();
  }

  WordNotifierTransactionResult addStatement(Statement statement) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    final added = state!.statements.add(statement);
    if (added) {
      state = state!.copyWith(appId: _generateId);
      _ref.read(wordChangesProvider.notifier).state = true;
      return WordNotifierTransactionResult.success();
    }
    return WordNotifierTransactionResult.itemAlreadyExists();
  }

  WordNotifierTransactionResult updateStatement(Statement statement) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    // Find the statement that we need to update
    // If the statement is not found, we will return the statement that
    // came in the parameter
    final statementToUpdate = state!.statements.firstWhere(
      (s) => s.id == statement.id, // return the statement we want to update
      orElse: () => statement, // return the statement that came in the parameter
    );
    // True, only when the statement is not found in the set
    if (statementToUpdate == statement) {
      return WordNotifierTransactionResult.itemDoesNotExist();
    }
    // Update the statement text and tranlation (only things may change)
    final updated = statementToUpdate.copyWith(
      text: statement.text,
      translation: statement.translation,
    );
    state!.statements.remove(statementToUpdate);
    state!.statements.add(updated);
    state = state!.copyWith(appId: _generateId);
    _ref.read(wordChangesProvider.notifier).state = true;
    return WordNotifierTransactionResult.success();
  }

  WordNotifierTransactionResult removeStatement(String id) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    final statement = state!.statements.firstWhere((s) => s.id == id);
    final removed = state!.statements.remove(statement);
    if (removed) {
      state = state!.copyWith(appId: _generateId);
      _ref.read(wordChangesProvider.notifier).state = true;
      return WordNotifierTransactionResult.success();
    }
    return WordNotifierTransactionResult.itemDoesNotExist();
  }

  WordNotifierTransactionResult addTag(MinimalTag tag) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    final added = state!.tags.add(tag);
    if (added) {
      state = state!.copyWith(appId: _generateId);
      _ref.read(wordChangesProvider.notifier).state = true;
      return WordNotifierTransactionResult.success();
    }
    return WordNotifierTransactionResult.itemAlreadyExists();
  }

  WordNotifierTransactionResult removeTag(MinimalTag tag) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    final removed = state!.tags.remove(tag);
    if (removed) {
      state = state!.copyWith(appId: _generateId);
      _ref.read(wordChangesProvider.notifier).state = true;
      return WordNotifierTransactionResult.success();
    }
    return WordNotifierTransactionResult.itemDoesNotExist();
  }

  WordNotifierTransactionResult addSynonym(MinimalWord word) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    final added = state!.synonyms.add(word);
    if (added) {
      state = state!.copyWith(appId: _generateId);
      _ref.read(wordChangesProvider.notifier).state = true;
      return WordNotifierTransactionResult.success();
    }
    return WordNotifierTransactionResult.itemAlreadyExists();
  }

  WordNotifierTransactionResult removeSynonym(MinimalWord word) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    final removed = state!.synonyms.remove(word);
    if (removed) {
      state = state!.copyWith(appId: _generateId);
      _ref.read(wordChangesProvider.notifier).state = true;
      return WordNotifierTransactionResult.success();
    }
    return WordNotifierTransactionResult.itemDoesNotExist();
  }

  WordNotifierTransactionResult addOpposite(MinimalWord word) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    final added = state!.opposites.add(word);
    if (added) {
      state = state!.copyWith(appId: _generateId);
      _ref.read(wordChangesProvider.notifier).state = true;
      return WordNotifierTransactionResult.success();
    }
    return WordNotifierTransactionResult.itemAlreadyExists();
  }

  WordNotifierTransactionResult removeOpposite(MinimalWord word) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    final removed = state!.opposites.remove(word);
    if (removed) {
      state = state!.copyWith(appId: _generateId);
      _ref.read(wordChangesProvider.notifier).state = true;
      return WordNotifierTransactionResult.success();
    }
    return WordNotifierTransactionResult.itemDoesNotExist();
  }
}
