import 'package:lexisnap/core/errors/exceptions.dart';
import 'package:lexisnap/features/home/data/models/statement_model.dart';
import 'package:lexisnap/features/home/domain/entities/statement.dart';

extension StatementToModel on Statement {
  StatementModel toModel() => StatementModel(
        id: null,
        text: text,
        wordId: wordId,
        translation: translation,
      );
}

extension ModelToStatement on StatementModel {
  Statement toEntity() {
    if (id == null || text == null) {
      throw const CouldNotMappingException(message: 'ID and text are required');
    }
    return Statement(
      id: id!,
      text: text!,
      wordId: wordId ?? '',
      translation: translation ?? '',
    );
  }
}
