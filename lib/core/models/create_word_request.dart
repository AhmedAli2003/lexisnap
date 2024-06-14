import 'package:json_annotation/json_annotation.dart';

part 'create_word_request.g.dart';

@JsonSerializable()
class CreateWordRequest {
  final String word;
  final String note;
  final List<String> translations;
  final List<String> definitions;

  const CreateWordRequest({
    required this.word,
    this.note = '',
    this.translations = const [],
    this.definitions = const [],
  });

  factory CreateWordRequest.fromJson(Map<String, dynamic> json) => _$CreateWordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWordRequestToJson(this);
}
