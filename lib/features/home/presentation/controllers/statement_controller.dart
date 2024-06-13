import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/data/repositories/statement_repository_impl.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';
import 'package:lexisnap/features/home/domain/repositories/statement_repository.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';

final statementProvider = StateProvider<Statement?>((_) => null);

final statementControllerProvider = Provider<StatementController>(
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

  void createStatement(BuildContext context, Statement statement) async {
    state.createStatementLoading = true;
    final either = await _repository.createStatement(statement);
    state.createStatementLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (statement) => _ref.read(statementProvider.notifier).update((_) => statement),
    );
  }

  void updateStatement(BuildContext context, Statement statement) async {
    state.updateStatementLoading = true;
    final either = await _repository.updateStatement(statement);
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
}

class StatementControllerState {
  bool createStatementLoading;
  bool updateStatementLoading;
  bool deleteStatementLoading;

  StatementControllerState({
    this.createStatementLoading = false,
    this.updateStatementLoading = false,
    this.deleteStatementLoading = false,
  });
}
