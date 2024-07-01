import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';
import 'package:uuid/uuid.dart';

class Word {
  final String id;
  final String appId;
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
    String? appId,
    required this.word,
    required this.definitions,
    required this.tags,
    required this.translations,
    required this.statements,
    required this.synonyms,
    required this.opposites,
    required this.note,
  }) : appId = appId ?? const Uuid().v4();

  Word copyWith({
    String? id,
    String? appId,
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
      appId: appId ?? this.appId,
      word: word ?? this.word,
      definitions: definitions ?? this.definitions,
      tags: tags ?? this.tags,
      translations: translations ?? this.translations,
      statements: statements ?? this.statements,
      synonyms: synonyms ?? this.synonyms,
      opposites: opposites ?? this.opposites,
      note: note ?? this.note,
    );
  }

  @override
  bool operator ==(covariant Word other) {
    if (identical(this, other)) return true;

    return other.id == id && other.appId == appId && other.word == word && other.note == note;
  }

  @override
  int get hashCode {
    return id.hashCode ^ appId.hashCode ^ word.hashCode ^ note.hashCode;
  }

  @override
  String toString() {
    return 'Word(id: $id, appId: $appId, word: $word, definitions: $definitions, tags: $tags, translations: $translations, statements: $statements, synonyms: $synonyms, opposites: $opposites, note: $note)';
  }
}
