import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_user_model.g.dart';

@immutable
@JsonSerializable()
class AppUserModel {
  final String googleId;
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final String profilePicture;
  final bool hasExtension;

  const AppUserModel({
    required this.googleId,
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.hasExtension,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) => _$AppUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserModelToJson(this);
}
