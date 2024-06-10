import 'package:json_annotation/json_annotation.dart';
import 'package:lexisnap/core/models/api_response.dart';

part 'auth_api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class AuthApiResponse<T> extends ApiResponse<T> {
  final String accessToken;
  final String expiresIn;

  const AuthApiResponse({
    required super.success,
    required super.message,
    required super.data,
    required this.accessToken,
    required this.expiresIn,
  });

  factory AuthApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$AuthApiResponseFromJson(json, fromJsonT);

  @override
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$AuthApiResponseToJson(this, toJsonT);
}
