import 'package:json_annotation/json_annotation.dart';

part 'create_statement_request.g.dart';

@JsonSerializable()
class CreateStatementRequest {
  final String text;
  final String word;
  final String translation;

  const CreateStatementRequest({
    required this.text,
    required this.word,
    this.translation = '',
  });

  factory CreateStatementRequest.fromJson(Map<String, dynamic> json) => _$CreateStatementRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateStatementRequestToJson(this);
}
