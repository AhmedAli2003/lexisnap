import 'package:json_annotation/json_annotation.dart';

part 'update_word_request.g.dart';

@JsonSerializable()
class UpdateWordRequest {
  final String word;
  final String? note;
  final List<String> definitions;
  final List<String> translations;
  final List<String> tags;
  final List<String> statements;
  final List<String> synonyms;
  final List<String> opposites;

  const UpdateWordRequest({
    required this.word,
    this.note,
    required this.definitions,
    required this.translations,
    required this.tags,
    required this.statements,
    required this.synonyms,
    required this.opposites,
  });

  factory UpdateWordRequest.fromJson(Map<String, dynamic> json) => _$UpdateWordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateWordRequestToJson(this);
}
