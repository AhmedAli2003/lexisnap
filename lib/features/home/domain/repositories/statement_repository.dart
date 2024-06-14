import 'package:fpdart/fpdart.dart';
import 'package:lexisnap/core/errors/failure.dart';
import 'package:lexisnap/core/models/create_statement_request.dart';
import 'package:lexisnap/core/models/update_statement_request.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';

abstract class StatementRepository {
  const StatementRepository();

  Future<Either<Failure, Statement>> getStatementById(String id);

  Future<Either<Failure, Statement>> createStatement(CreateStatementRequest statement);

  Future<Either<Failure, Statement>> updateStatement(String id, UpdateStatementRequest statement);

  Future<Either<Failure, Unit>> deleteStatement(String id);
}
