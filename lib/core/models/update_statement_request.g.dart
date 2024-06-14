// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_statement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateStatementRequest _$UpdateStatementRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateStatementRequest(
      text: json['text'] as String? ?? '',
      translation: json['translation'] as String? ?? '',
    );

Map<String, dynamic> _$UpdateStatementRequestToJson(
        UpdateStatementRequest instance) =>
    <String, dynamic>{
      'text': instance.text,
      'translation': instance.translation,
    };
