// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_statement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateStatementRequest _$CreateStatementRequestFromJson(
        Map<String, dynamic> json) =>
    CreateStatementRequest(
      text: json['text'] as String,
      word: json['word'] as String,
      translation: json['translation'] as String? ?? '',
    );

Map<String, dynamic> _$CreateStatementRequestToJson(
        CreateStatementRequest instance) =>
    <String, dynamic>{
      'text': instance.text,
      'word': instance.word,
      'translation': instance.translation,
    };
