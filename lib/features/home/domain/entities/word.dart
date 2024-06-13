import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';

class Word {
  final String id;
  final String word;
  final List<String> definitions;
  final List<MinimalTag> tags;
  final List<String> translations;
  final List<Statement> statements;
  final List<MinimalWord> synonyms;
  final List<MinimalWord> opposites;
  final String note;

  const Word({
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
    List<String>? definitions,
    List<MinimalTag>? tags,
    List<String>? translations,
    List<Statement>? statements,
    List<MinimalWord>? synonyms,
    List<MinimalWord>? opposites,
    String? note,
  }) {
    return Word(
      id: id ?? this.id,
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
}
