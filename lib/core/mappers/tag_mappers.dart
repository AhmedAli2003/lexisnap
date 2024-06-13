import 'package:lexisnap/core/errors/exceptions.dart';
import 'package:lexisnap/core/mappers/word_mappers.dart';
import 'package:lexisnap/features/home/data/models/minimal_tag_model.dart';
import 'package:lexisnap/features/home/data/models/tag_model.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/domain/entities/tag.dart';

extension TagToModel on Tag {
  TagModel toModel() => TagModel(
        id: id,
        name: name,
        words: words
            .map(
              (word) => word.toModel(),
            )
            .toList(),
      );
}

extension ModelToTag on TagModel {
  Tag toEntity() {
    if (id == null || name == null) {
      throw CouldNotMappingException(message: 'Id and name must be specified');
    }
    return Tag(id: id!, name: name!, words: words == null ? [] : words!.map((word) => word.toEntity()).toList());
  }
}

extension MinimalTagToModel on MinimalTag {
  MinimalTagModel toModel() => MinimalTagModel(
        id: id,
        name: name,
      );
}

extension ModelToMinimalTag on MinimalTagModel {
  MinimalTag toEntity() {
    if (id == null || name == null) {
      throw CouldNotMappingException(message: 'Id and name must be specified');
    }
    return MinimalTag(id: id!, name: name!);
  }
}
