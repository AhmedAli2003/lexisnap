import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier_transaction_result.dart';

final wordChangesProvider = StateProvider.autoDispose<bool>((ref) => false);

final wordProvider = StateNotifierProvider.autoDispose<WordNotifier, Word?>(
  name: 'wordProvider',
  (ref) {
    // This is a milliseconds time between loading and build the update word scaffold
    // after we create a new word, the create word method in word controller will
    // assign the new word to the wordProvider, but in this time between assiging and building ui
    // the wordProvider will be desposed, so I prevent disposing in this situation by keep it alive
    // for 100 ms as there is no listeners, I should found another solution later
    final link = ref.keepAlive();
    Future.delayed(const Duration(milliseconds: 100), () {
      link.close();
    });
    return WordNotifier(ref: ref, state: null);
  },
);

final wordTextProvider = Provider.autoDispose<String>((ref) {
  return ref.watch(wordProvider.select((word) => word?.word ?? ''));
});

final wordDefinitionsProvider = Provider.autoDispose<Set<String>>((ref) {
  return ref.watch(wordProvider.select((word) {
    return {...?word?.definitions};
  }));
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

  // final _uuid = const Uuid();

  // String get _generateId => _uuid.v4();

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
      state = state!.copyWith(translations: {...state!.translations});
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
    state = state!.copyWith(translations: {...state!.translations});
    _ref.read(wordChangesProvider.notifier).state = true;
    return WordNotifierTransactionResult.success();
  }

  WordNotifierTransactionResult addDefinition(String definition) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    final added = state!.definitions.add(definition);
    if (added) {
      state = state!.copyWith(definitions: {...state!.definitions});
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
    state = state!.copyWith(definitions: {...state!.definitions});
    _ref.read(wordChangesProvider.notifier).state = true;
    return WordNotifierTransactionResult.success();
  }

  WordNotifierTransactionResult removeDifinition(String definition) {
    if (state == null) {
      return WordNotifierTransactionResult.stateIsNull();
    }
    final removed = state!.definitions.remove(definition);
    if (removed) {
      state = state!.copyWith(definitions: {...state!.definitions});
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
      state = state!.copyWith(statements: {...state!.statements});
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
    state = state!.copyWith(statements: {...state!.statements});
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
      state = state!.copyWith(statements: {...state!.statements});
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
      state = state!.copyWith(tags: {...state!.tags});
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
      state = state!.copyWith(tags: {...state!.tags});
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
      state = state!.copyWith(synonyms: {...state!.synonyms});
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
      state = state!.copyWith(synonyms: {...state!.synonyms});
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
      state = state!.copyWith(opposites: {...state!.opposites});
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
      state = state!.copyWith(opposites: {...state!.opposites});
      _ref.read(wordChangesProvider.notifier).state = true;
      return WordNotifierTransactionResult.success();
    }
    return WordNotifierTransactionResult.itemDoesNotExist();
  }
}
