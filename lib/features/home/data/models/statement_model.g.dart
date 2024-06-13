// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatementModel _$StatementModelFromJson(Map<String, dynamic> json) =>
    StatementModel(
      id: json['_id'] as String?,
      text: json['text'] as String?,
      wordId: json['wordId'] as String?,
      translation: json['translation'] as String?,
    );

Map<String, dynamic> _$StatementModelToJson(StatementModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'text': instance.text,
      'wordId': instance.wordId,
      'translation': instance.translation,
    };
