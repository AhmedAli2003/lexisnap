import 'package:json_annotation/json_annotation.dart';
import 'package:lexisnap/core/models/api_response.dart';

part 'pagination_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationResponse<T> extends ApiResponse<T> {
  final int? totalWords;
  final int? totalPages;
  final int? currentPage;

  const PaginationResponse({
    required super.success,
    required super.message,
    required super.data,
    required this.totalWords,
    required this.totalPages,
    required this.currentPage,
  });

  factory PaginationResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginationResponseFromJson(json, fromJsonT);

  @override
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$PaginationResponseToJson(this, toJsonT);
}
