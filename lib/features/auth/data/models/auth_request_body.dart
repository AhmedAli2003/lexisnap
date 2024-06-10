import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_request_body.g.dart';

@immutable
@JsonSerializable()
class AuthRequestBody {
  final String idToken;
  const AuthRequestBody(this.idToken);

  factory AuthRequestBody.fromJson(Map<String, dynamic> json) => _$AuthRequestBodyFromJson(json);
  Map<String, dynamic> toJson() => _$AuthRequestBodyToJson(this);
}
