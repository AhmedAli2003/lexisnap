import 'package:fpdart/fpdart.dart';
import 'package:lexisnap/core/errors/failure.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/domain/entities/tag.dart';

abstract class TagRepository {
  const TagRepository();

  Future<Either<Failure, List<MinimalTag>>> getAllTags({int page = 1});

  Future<Either<Failure, Tag>> getTagById(String id);

  Future<Either<Failure, Tag>> createTag(Tag tag);

  Future<Either<Failure, MinimalTag>> updateTag(MinimalTag tag);

  Future<Either<Failure, Unit>> deleteTag(String id);
}
