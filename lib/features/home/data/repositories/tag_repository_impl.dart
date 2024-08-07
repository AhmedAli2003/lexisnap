import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lexisnap/core/errors/exceptions.dart';
import 'package:lexisnap/core/errors/failure.dart';
import 'package:lexisnap/core/mappers/tag_mappers.dart';
import 'package:lexisnap/core/shared/internet_checker.dart';
import 'package:lexisnap/core/shared/shared_preferences_manager.dart';
import 'package:lexisnap/features/home/data/data_sources/tags_remote_data_source.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/domain/entities/tag.dart';
import 'package:lexisnap/features/home/domain/repositories/tag_repository.dart';
import 'package:lexisnap/core/models/create_or_update_tag_request.dart';

final tagRepositoryProvider = Provider<TagRepository>(
  (ref) => TagRepositoryImpl(
    ref: ref,
    dataSource: ref.read(tagsRemoteDataSourceProvider),
  ),
);

class TagRepositoryImpl implements TagRepository {
  final Ref _ref;
  final TagsRemoteDataSource _dataSource;

  const TagRepositoryImpl({
    required Ref ref,
    required TagsRemoteDataSource dataSource,
  })  : _ref = ref,
        _dataSource = dataSource;

  @override
  Future<Either<Failure, Tag>> createTag(CreateOrUpdateTagRequest tag) async {
    try {
      if (!(await _ref.read(internetCheckerProvider).hasConnection)) {
        throw const NoInternetException();
      }
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.createTag(accessToken: accessToken, tag: tag);
      if (!response.success || response.data == null) {
        throw ServerException(message: response.message!);
      }
      return Right(response.data!.toEntity());
    } on AppException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTag(String id) async {
    try {
      if (!(await _ref.read(internetCheckerProvider).hasConnection)) {
        throw const NoInternetException();
      }
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.deleteTag(accessToken: accessToken, id: id);
      if (response.response.statusCode != 204) {
        throw const ServerException(message: 'Could not delete tag, try again');
      }
      return const Right(unit);
    } on AppException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<MinimalTag>>> getAllTags({int page = 1}) async {
    try {
      if (!(await _ref.read(internetCheckerProvider).hasConnection)) {
        throw const NoInternetException();
      }
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.getAllTags(accessToken: accessToken, page: page);
      if (!response.success || response.data == null) {
        throw ServerException(message: response.message!);
      }
      return Right(response.data!.map((tag) => tag.toEntity()).toList());
    } on AppException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Tag>> getTagById(String id) async {
    try {
      if (!(await _ref.read(internetCheckerProvider).hasConnection)) {
        throw const NoInternetException();
      }
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.getTagById(accessToken: accessToken, id: id);
      if (!response.success || response.data == null) {
        throw ServerException(message: response.message!);
      }
      return Right(response.data!.toEntity());
    } on AppException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, MinimalTag>> updateTag(String id, CreateOrUpdateTagRequest tag) async {
    try {
      if (!(await _ref.read(internetCheckerProvider).hasConnection)) {
        throw const NoInternetException();
      }
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.updateTag(
        id: id,
        accessToken: accessToken,
        tag: tag,
      );
      if (!response.success || response.data == null) {
        throw ServerException(message: response.message!);
      }
      return Right(response.data!.toEntity());
    } on AppException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
