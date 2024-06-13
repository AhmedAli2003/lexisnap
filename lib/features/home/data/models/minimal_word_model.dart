import 'package:json_annotation/json_annotation.dart';

part 'minimal_word_model.g.dart';

@JsonSerializable()
class MinimalWordModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? word;

  const MinimalWordModel({
    required this.id,
    required this.word,
  });

  factory MinimalWordModel.fromJson(Map<String, dynamic> json) => _$MinimalWordModelFromJson(json);
  Map<String, dynamic> toJson() => _$MinimalWordModelToJson(this);
}
