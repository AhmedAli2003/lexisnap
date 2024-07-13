import 'package:flutter/foundation.dart';

import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';

class Word implements Comparable<Word> {
  final String id;
  final String word;
  final Set<String> definitions;
  final Set<MinimalTag> tags;
  final Set<String> translations;
  final Set<Statement> statements;
  final Set<MinimalWord> synonyms;
  final Set<MinimalWord> opposites;
  final String note;

  Word({
    required this.id,
    required this.word,
    required this.definitions,
    required this.tags,
    required this.translations,
    required this.statements,
    required this.synonyms,
    required this.opposites,
    required this.note,
  });

  Word copyWith({
    String? id,
    String? word,
    Set<String>? definitions,
    Set<MinimalTag>? tags,
    Set<String>? translations,
    Set<Statement>? statements,
    Set<MinimalWord>? synonyms,
    Set<MinimalWord>? opposites,
    String? note,
  }) {
    return Word(
      id: id ?? this.id,
      word: word ?? this.word,
      definitions: definitions != null ? {...definitions} : {...this.definitions},
      tags: tags != null ? {...tags} : {...this.tags},
      translations: translations != null ? {...translations} : {...this.translations},
      statements: statements != null ? {...statements} : {...this.statements},
      synonyms: synonyms != null ? {...synonyms} : {...this.synonyms},
      opposites: opposites != null ? {...opposites} : {...this.opposites},
      note: note ?? this.note,
    );
  }

  @override
  String toString() {
    return 'Word(id: $id, word: $word, definitions: $definitions, tags: $tags, translations: $translations, statements: $statements, synonyms: $synonyms, opposites: $opposites, note: $note)';
  }

  @override
  bool operator ==(covariant Word other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.word == word &&
        setEquals(other.definitions, definitions) &&
        setEquals(other.tags, tags) &&
        setEquals(other.translations, translations) &&
        setEquals(other.statements, statements) &&
        setEquals(other.synonyms, synonyms) &&
        setEquals(other.opposites, opposites) &&
        other.note == note;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        word.hashCode ^
        definitions.hashCode ^
        tags.hashCode ^
        translations.hashCode ^
        statements.hashCode ^
        synonyms.hashCode ^
        opposites.hashCode ^
        note.hashCode;
  }

  @override
  int compareTo(Word other) {
    return word.compareTo(other.word);
  }
}
