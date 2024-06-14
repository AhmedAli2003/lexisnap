// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_word_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateWordRequest _$UpdateWordRequestFromJson(Map<String, dynamic> json) =>
    UpdateWordRequest(
      word: json['word'] as String,
      note: json['note'] as String?,
      definitions: (json['definitions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      translations: (json['translations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      statements: (json['statements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      synonyms:
          (json['synonyms'] as List<dynamic>).map((e) => e as String).toList(),
      opposites:
          (json['opposites'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UpdateWordRequestToJson(UpdateWordRequest instance) =>
    <String, dynamic>{
      'word': instance.word,
      'note': instance.note,
      'definitions': instance.definitions,
      'translations': instance.translations,
      'tags': instance.tags,
      'statements': instance.statements,
      'synonyms': instance.synonyms,
      'opposites': instance.opposites,
    };
