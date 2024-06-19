import 'package:json_annotation/json_annotation.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';

part 'update_word_request.g.dart';

@JsonSerializable()
class UpdateWordRequest {
  final String word;
  final String note;
  final List<String> definitions;
  final List<String> translations;
  final List<String> tags;
  final List<String> statements;
  final List<String> synonyms;
  final List<String> opposites;

  const UpdateWordRequest({
    required this.word,
    required this.note,
    required this.definitions,
    required this.translations,
    required this.tags,
    required this.statements,
    required this.synonyms,
    required this.opposites,
  });

  factory UpdateWordRequest.fromWord(Word word) {
    return UpdateWordRequest(
      word: word.word,
      note: word.note,
      definitions: word.definitions,
      translations: word.translations,
      tags: word.tags.map((tag) => tag.id).toList(),
      statements: word.statements.map((statement) => statement.id).toList(),
      synonyms: word.synonyms.map((syn) => syn.id).toList(),
      opposites: word.opposites.map((opp) => opp.id).toList(),
    );
  }

  factory UpdateWordRequest.fromJson(Map<String, dynamic> json) => _$UpdateWordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateWordRequestToJson(this);
}
