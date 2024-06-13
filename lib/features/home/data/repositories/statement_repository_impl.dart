import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lexisnap/core/errors/exceptions.dart';
import 'package:lexisnap/core/errors/failure.dart';
import 'package:lexisnap/core/mappers/statement_mappers.dart';
import 'package:lexisnap/core/shared/shared_preferences_manager.dart';
import 'package:lexisnap/features/home/data/data_sources/statements_remote_data_source.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';
import 'package:lexisnap/features/home/domain/repositories/statement_repository.dart';

final statementRepositoryProvider = Provider<StatementRepository>(
  (ref) => StatementRepositoryImpl(
    ref: ref,
    dataSource: ref.read(statementsRemoteDataSourceProvider),
  ),
);

class StatementRepositoryImpl implements StatementRepository {
  final Ref _ref;
  final StatementsRemoteDataSource _dataSource;

  const StatementRepositoryImpl({
    required Ref ref,
    required StatementsRemoteDataSource dataSource,
  })  : _ref = ref,
        _dataSource = dataSource;

  @override
  Future<Either<Failure, Statement>> createStatement(Statement statement) async {
    try {
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.createStatement(
        accessToken: accessToken,
        statement: statement.toModel(),
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

  @override
  Future<Either<Failure, Unit>> deleteStatement(String id) async {
    try {
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.deleteStatement(
        accessToken: accessToken,
        id: id,
      );
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
  Future<Either<Failure, Statement>> updateStatement(Statement statement) async {
    try {
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.updateStatement(
        id: statement.id,
        accessToken: accessToken,
        statement: statement.toModel(),
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
