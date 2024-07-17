import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lexisnap/core/errors/exceptions.dart';
import 'package:lexisnap/core/errors/failure.dart';
import 'package:lexisnap/core/mappers/statement_mappers.dart';
import 'package:lexisnap/core/models/create_statement_request.dart';
import 'package:lexisnap/core/models/update_statement_request.dart';
import 'package:lexisnap/core/shared/internet_checker.dart';
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
  Future<Either<Failure, Statement>> createStatement(CreateStatementRequest statement) async {
    try {
      if (!(await _ref.read(internetCheckerProvider).hasConnection)) {
        throw const NoInternetException();
      }
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.createStatement(
        accessToken: accessToken,
        statement: statement,
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

  @override
  Future<Either<Failure, Unit>> deleteStatement(String id) async {
    try {
      if (!(await _ref.read(internetCheckerProvider).hasConnection)) {
        throw const NoInternetException();
      }
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.deleteStatement(
        accessToken: accessToken,
        id: id,
      );
      if (response.response.statusCode != 204) {
        throw const ServerException(message: 'Could not delete statement, try again');
      }
      return const Right(unit);
    } on AppException catch (e) {
      return Left(Failure(e));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Statement>> updateStatement(String id, UpdateStatementRequest statement) async {
    try {
      if (!(await _ref.read(internetCheckerProvider).hasConnection)) {
        throw const NoInternetException();
      }
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.updateStatement(
        id: id,
        accessToken: accessToken,
        statement: statement,
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

  @override
  Future<Either<Failure, Statement>> getStatementById(String id) async {
    try {
      if (!(await _ref.read(internetCheckerProvider).hasConnection)) {
        throw const NoInternetException();
      }
      final accessToken = _ref.read(sharedPrefProvider).getAccessToken();
      final response = await _dataSource.getStatementById(id: id, accessToken: accessToken);
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
