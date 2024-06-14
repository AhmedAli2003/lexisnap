import 'package:fpdart/fpdart.dart';
import 'package:lexisnap/core/errors/failure.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/domain/entities/tag.dart';
import 'package:lexisnap/core/models/create_or_update_tag_request.dart';

abstract class TagRepository {
  const TagRepository();

  Future<Either<Failure, List<MinimalTag>>> getAllTags({int page = 1});

  Future<Either<Failure, Tag>> getTagById(String id);

  Future<Either<Failure, Tag>> createTag(CreateOrUpdateTagRequest tag);

  Future<Either<Failure, MinimalTag>> updateTag(String id, CreateOrUpdateTagRequest tag);

  Future<Either<Failure, Unit>> deleteTag(String id);
}
