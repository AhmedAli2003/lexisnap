import 'package:json_annotation/json_annotation.dart';

part 'create_or_update_tag_request.g.dart';

@JsonSerializable()
class CreateOrUpdateTagRequest {
  final String name;

  const CreateOrUpdateTagRequest({
    required this.name,
  });

  factory CreateOrUpdateTagRequest.fromJson(Map<String, dynamic> json) => _$CreateOrUpdateTagRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrUpdateTagRequestToJson(this);
}
