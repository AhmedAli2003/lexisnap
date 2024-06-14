// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_word_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateWordRequest _$CreateWordRequestFromJson(Map<String, dynamic> json) =>
    CreateWordRequest(
      word: json['word'] as String,
      note: json['note'] as String? ?? '',
      translations: (json['translations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      definitions: (json['definitions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CreateWordRequestToJson(CreateWordRequest instance) =>
    <String, dynamic>{
      'word': instance.word,
      'note': instance.note,
      'translations': instance.translations,
      'definitions': instance.definitions,
    };
