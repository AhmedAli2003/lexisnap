import 'package:fpdart/fpdart.dart';
import 'package:lexisnap/core/errors/failure.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';

abstract class StatementRepository {
  const StatementRepository();

  Future<Either<Failure, Statement>> createStatement(Statement statement);

  Future<Either<Failure, Statement>> updateStatement(Statement statement);

  Future<Either<Failure, Unit>> deleteStatement(String id);
}
