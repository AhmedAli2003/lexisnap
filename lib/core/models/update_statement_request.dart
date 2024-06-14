import 'package:json_annotation/json_annotation.dart';

part 'update_statement_request.g.dart';

@JsonSerializable()
class UpdateStatementRequest {
  final String text;
  final String translation;

  const UpdateStatementRequest({
    this.text = '',
    this.translation = '',
  });

  factory UpdateStatementRequest.fromJson(Map<String, dynamic> json) => _$UpdateStatementRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateStatementRequestToJson(this);
}
