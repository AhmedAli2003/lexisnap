import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/models/create_statement_request.dart';
import 'package:lexisnap/core/models/update_statement_request.dart';
import 'package:lexisnap/features/home/data/repositories/statement_repository_impl.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';
import 'package:lexisnap/features/home/domain/repositories/statement_repository.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';

final statementProvider = StateProvider<Statement?>((_) => null);

final statementControllerProvider = StateNotifierProvider<StatementController, StatementControllerState>(
  (ref) => StatementController(
    ref: ref,
    repository: ref.read(statementRepositoryProvider),
  ),
);

class StatementController extends StateNotifier<StatementControllerState> {
  StatementController({
    required Ref ref,
    required StatementRepository repository,
  })  : _ref = ref,
        _repository = repository,
        super(StatementControllerState());

  final Ref _ref;
  final StatementRepository _repository;

  void createStatement(BuildContext context, CreateStatementRequest statement) async {
    state.createStatementLoading = true;
    final either = await _repository.createStatement(statement);
    state.createStatementLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (statement) => _ref.read(statementProvider.notifier).update((_) => statement),
    );
  }

  void updateStatement({
    required BuildContext context,
    required String id,
    required UpdateStatementRequest statement,
  }) async {
    state.updateStatementLoading = true;
    final either = await _repository.updateStatement(id, statement);
    state.updateStatementLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (statement) => _ref.read(statementProvider.notifier).update((_) => statement),
    );
  }

  void deleteStatement(BuildContext context, String id) async {
    state.deleteStatementLoading = true;
    final either = await _repository.deleteStatement(id);
    state.deleteStatementLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (_) => _ref.read(statementProvider.notifier).update((_) => null),
    );
  }

  void getStatementById(BuildContext context, String id) async {
    state.getStatementByIdLoading = true;
    final either = await _repository.getStatementById(id);
    state.getStatementByIdLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (statement) => _ref.read(statementProvider.notifier).update((_) => statement),
    );
  }
}

class StatementControllerState {
  bool getStatementByIdLoading;
  bool createStatementLoading;
  bool updateStatementLoading;
  bool deleteStatementLoading;

  StatementControllerState({
    this.getStatementByIdLoading = false,
    this.createStatementLoading = false,
    this.updateStatementLoading = false,
    this.deleteStatementLoading = false,
  });
}
