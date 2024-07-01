import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';

final statementBoxStateProvider = StateProvider<StatementBoxState>((_) => const StatementBoxState());

class StatementBoxState {
  final Statement? statement;
  final bool update;
  final bool showTextField;
  final String? wordId;

  const StatementBoxState({
    this.statement,
    this.update = false,
    this.showTextField = false,
    this.wordId,
  });

  StatementBoxState copyWith({
    Statement? statement,
    bool? update,
    bool? showTextField,
    String? wordId,
  }) {
    return StatementBoxState(
      statement: statement ?? this.statement,
      update: update ?? this.update,
      showTextField: showTextField ?? this.showTextField,
      wordId: wordId ?? this.wordId,
    );
  }

  @override
  bool operator ==(covariant StatementBoxState other) {
    if (identical(this, other)) return true;

    return other.statement == statement && other.update == update && other.showTextField == showTextField && other.wordId == wordId;
  }

  @override
  int get hashCode => statement.hashCode ^ update.hashCode ^ showTextField.hashCode ^ wordId.hashCode;
}
