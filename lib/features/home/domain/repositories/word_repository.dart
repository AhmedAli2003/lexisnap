import 'package:fpdart/fpdart.dart';
import 'package:lexisnap/core/errors/failure.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/domain/entities/word.dart';

abstract class WordRepository {
  const WordRepository();

  Future<Either<Failure, List<MinimalWord>>> getWordsOverview();

  Future<Either<Failure, List<Word>>> getAllWords({int page = 1});

  Future<Either<Failure, Word>> getWordById(String id);

  Future<Either<Failure, Word>> createWord(Word word);

  Future<Either<Failure, Word>> updateWord(Word word);

  Future<Either<Failure, Unit>> deleteWord(String id);
}
