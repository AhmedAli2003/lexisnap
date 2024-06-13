// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordModel _$WordModelFromJson(Map<String, dynamic> json) => WordModel(
      id: json['id'] as String?,
      word: json['word'] as String?,
      definitions: (json['definitions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => MinimalTagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      translations: (json['translations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      statements: (json['statements'] as List<dynamic>?)
          ?.map((e) => StatementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      synonyms: (json['synonyms'] as List<dynamic>?)
          ?.map((e) => MinimalWordModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      opposites: (json['opposites'] as List<dynamic>?)
          ?.map((e) => MinimalWordModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      note: json['note'] as String,
    );

Map<String, dynamic> _$WordModelToJson(WordModel instance) => <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'definitions': instance.definitions,
      'tags': instance.tags?.map((e) => e.toJson()).toList(),
      'translations': instance.translations,
      'statements': instance.statements?.map((e) => e.toJson()).toList(),
      'synonyms': instance.synonyms?.map((e) => e.toJson()).toList(),
      'opposites': instance.opposites?.map((e) => e.toJson()).toList(),
      'note': instance.note,
    };
