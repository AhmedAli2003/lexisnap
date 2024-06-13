import 'package:json_annotation/json_annotation.dart';
import 'package:lexisnap/features/home/data/models/minimal_tag_model.dart';
import 'package:lexisnap/features/home/data/models/minimal_word_model.dart';
import 'package:lexisnap/features/home/data/models/statement_model.dart';

part 'word_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WordModel {
  final String? id;
  final String? word;
  final List<String>? definitions;
  final List<MinimalTagModel>? tags;
  final List<String>? translations;
  final List<StatementModel>? statements;
  final List<MinimalWordModel>? synonyms;
  final List<MinimalWordModel>? opposites;
  final String note;

  const WordModel({
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

  factory WordModel.fromJson(Map<String, dynamic> json) => _$WordModelFromJson(json);
  Map<String, dynamic> toJson() => _$WordModelToJson(this);
}
