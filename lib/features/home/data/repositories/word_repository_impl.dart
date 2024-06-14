import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lexisnap/core/errors/exceptions.dart';
import 'package:lexisnap/core/errors/failure.dart';
import 'package:lexisnap/core/mappers/word_mappers.dart';
import 'package:lexisnap/core/models/create_word_request.dart';
import 'package:lexisnap/core/models/update_word_request.dart';
import 'package:lexisnap/core/shared/shared_preferences_manager.dart';
import 'package:lexisnap/features/home/data/data_sources/words_remote_data_source.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';
import 'package:lexisnap/features/home/domain/repositories/word_repository.dart';

final wordRepositoryProvider = Provider<WordRepository>(
  (ref) => WordRepositoryImpl(
    ref: ref,
    dataSource: ref.read(wordsRemoteDataSourceProvider),
  ),
);

class WordRepositoryImpl implements WordRepository {
  final Ref _ref;
  final WordsRemoteDataSource _dataSource;

  const WordRepositoryImpl({
    required Ref ref,
    required WordsRemoteDataSource dataSource,
  })  : _ref = ref,
        _dataSource = dataSource;

  @override
  Future<Either<Failure, Word>> createWord(CreateWordRequest word) async {
    try {
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.createWord(accessToken: accessToken, word: word);
      if (!response.success || response.data == null) {
        throw ServerException(message: response.message!);
      }
      return Right(response.data!.toEntity());
    } on ServerException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteWord(String id) async {
    try {
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.deleteWord(id: id, accessToken: accessToken);
      if (!response.success) {
        throw ServerException(message: response.message!);
      }
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<Word>>> getAllWords({int page = 1}) async {
    try {
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.getAllWords(accessToken: accessToken, page: page);
      if (!response.success || response.data == null) {
        throw ServerException(message: response.message!);
      }
      return Right(response.data!.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Word>> getWordById(String id) async {
    try {
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.getWordById(id: id, accessToken: accessToken);
      if (!response.success || response.data == null) {
        throw ServerException(message: response.message!);
      }
      return Right(response.data!.toEntity());
    } on ServerException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<MinimalWord>>> getWordsOverview() async {
    try {
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.getWordsOverview(accessToken: accessToken);
      if (!response.success || response.data == null) {
        throw ServerException(message: response.message!);
      }
      return Right(response.data!.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Word>> updateWord(String id, UpdateWordRequest word) async {
    try {
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.updateWord(
        id: id,
        accessToken: accessToken,
        word: word,
      );
      if (!response.success || response.data == null) {
        throw ServerException(message: response.message!);
      }
      return Right(response.data!.toEntity());
    } on ServerException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}
