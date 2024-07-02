// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lexisnap/core/models/create_statement_request.dart';
import 'package:lexisnap/core/models/update_statement_request.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/features/home/data/repositories/statement_repository_impl.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';
import 'package:lexisnap/features/home/domain/repositories/statement_repository.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';

final statementProvider = StateProvider<Statement?>((_) => null);

final statementControllerProvider = StateNotifierProvider<StatementController, StatementLoadingState>(
  (ref) => StatementController(
    ref: ref,
    repository: ref.read(statementRepositoryProvider),
  ),
);

class StatementController extends StateNotifier<StatementLoadingState> {
  StatementController({
    required Ref ref,
    required StatementRepository repository,
  })  : _ref = ref,
        _repository = repository,
        super(const StatementLoadingState());

  final Ref _ref;
  final StatementRepository _repository;

  Future<void> createStatement({
    required BuildContext context,
    required CreateStatementRequest statement,
  }) async {
    state = state.copyWith(createStatement: true);
    final either = await _repository.createStatement(statement);
    state = state.copyWith(createStatement: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (statement) {
        _ref.read(statementProvider.notifier).update((_) => statement);
        _ref.read(wordProvider.notifier).addStatement(statement);
      },
    );
  }

  Future<void> updateStatement({
    required BuildContext context,
    required String id,
    required UpdateStatementRequest statement,
  }) async {
    state = state.copyWith(updateStatement: true);
    final either = await _repository.updateStatement(id, statement);
    state = state.copyWith(updateStatement: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (statement) {
        _ref.read(statementProvider.notifier).update((_) => statement);
        _ref.read(wordProvider.notifier).updateStatement(statement);
      },
    );
  }

  void deleteStatement(BuildContext context, String id) async {
    state = state.copyWith(deleteStatement: true);
    _ref.read(wordProvider.notifier).removeStatement(id);
    final either = await _repository.deleteStatement(id);
    state = state.copyWith(deleteStatement: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (_) => _ref.read(statementProvider.notifier).update((_) => null),
    );
  }

  void getStatementById(BuildContext context, String id) async {
    state = state.copyWith(getStatementById: true);
    final either = await _repository.getStatementById(id);
    state = state.copyWith(getStatementById: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (statement) => _ref.read(statementProvider.notifier).update((_) => statement),
    );
  }
}

class StatementLoadingState {
  final bool createStatement;
  final bool getStatementById;
  final bool updateStatement;
  final bool deleteStatement;

  const StatementLoadingState({
    this.createStatement = false,
    this.getStatementById = false,
    this.updateStatement = false,
    this.deleteStatement = false,
  });

  StatementLoadingState copyWith({
    bool? createStatement,
    bool? getStatementById,
    bool? updateStatement,
    bool? deleteStatement,
  }) {
    return StatementLoadingState(
      createStatement: createStatement ?? this.createStatement,
      getStatementById: getStatementById ?? this.getStatementById,
      updateStatement: updateStatement ?? this.updateStatement,
      deleteStatement: deleteStatement ?? this.deleteStatement,
    );
  }
}
