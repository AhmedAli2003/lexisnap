import 'package:json_annotation/json_annotation.dart';

part 'minimal_tag_model.g.dart';

@JsonSerializable()
class MinimalTagModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;

  const MinimalTagModel({
    required this.id,
    required this.name,
  });

  factory MinimalTagModel.fromJson(Map<String, dynamic> json) => _$MinimalTagModelFromJson(json);
  Map<String, dynamic> toJson() => _$MinimalTagModelToJson(this);
}
