import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';

class Tag {
  final String id;
  final String name;
  final List<MinimalWord> words;

  const Tag({
    required this.id,
    required this.name,
    required this.words,
  });

  Tag copyWith({
    String? id,
    String? name,
    List<MinimalWord>? words,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      words: words ?? this.words,
    );
  }
}
