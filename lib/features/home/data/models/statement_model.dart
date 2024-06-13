import 'package:json_annotation/json_annotation.dart';

part 'statement_model.g.dart';

@JsonSerializable()
class StatementModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? text;
  final String? wordId;
  final String? translation;

  const StatementModel({
    required this.id,
    required this.text,
    required this.wordId,
    required this.translation,
  });

  factory StatementModel.fromJson(Map<String, dynamic> json) => _$StatementModelFromJson(json);
  Map<String, dynamic> toJson() => _$StatementModelToJson(this);
}
