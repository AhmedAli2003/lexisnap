import 'package:lexisnap/core/errors/exceptions.dart';
import 'package:lexisnap/core/mappers/statement_mappers.dart';
import 'package:lexisnap/core/mappers/tag_mappers.dart';
import 'package:lexisnap/features/home/data/models/minimal_word_model.dart';
import 'package:lexisnap/features/home/data/models/word_model.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';

extension WordToModel on Word {
  WordModel toModel() => WordModel(
        id: null,
        word: word,
        definitions: definitions.toList(),
        tags: tags.map((t) => t.toModel()).toList(),
        translations: translations.toList(),
        statements: statements.map((s) => s.toModel()).toList(),
        synonyms: synonyms.map((s) => s.toModel()).toList(),
        opposites: opposites.map((o) => o.toModel()).toList(),
        note: note,
      );
}

extension ModelToWord on WordModel {
  Word toEntity() {
    if (id == null || word == null) {
      throw const CouldNotMappingException(message: 'id or word is null');
    }
    return Word(
      id: id!,
      word: word!,
      definitions: definitions?.toSet() ?? {},
      tags: tags == null ? {} : tags!.map((e) => e.toEntity()).toSet(),
      translations: translations?.toSet() ?? {},
      statements: statements == null ? {} : statements!.map((s) => s.toEntity()).toSet(),
      synonyms: synonyms == null ? {} : synonyms!.map((s) => s.toEntity()).toSet(),
      opposites: opposites == null ? {} : opposites!.map((s) => s.toEntity()).toSet(),
      note: note,
    );
  }
}

extension MinimalWordToModel on MinimalWord {
  MinimalWordModel toModel() => MinimalWordModel(id: id, word: word);
}

extension ModelToMinimalWord on MinimalWordModel {
  MinimalWord toEntity() {
    if (id == null || word == null) {
      throw const CouldNotMappingException(message: 'id or word is null');
    }
    return MinimalWord(id: id!, word: word!);
  }
}

extension ToMinimal on Word {
  MinimalWord toMinimal() => MinimalWord(id: id, word: word);
}
