import 'package:json_annotation/json_annotation.dart';
import 'package:lexisnap/features/home/data/models/minimal_word_model.dart';

part 'tag_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TagModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final List<MinimalWordModel>? words;

  const TagModel({
    required this.id,
    required this.name,
    required this.words,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) => _$TagModelFromJson(json);
  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}
