// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagModel _$TagModelFromJson(Map<String, dynamic> json) => TagModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      words: (json['words'] as List<dynamic>?)
          ?.map((e) => MinimalWordModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'words': instance.words?.map((e) => e.toJson()).toList(),
    };
