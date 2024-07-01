import 'package:flutter/foundation.dart';

import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';

class Tag {
  final String id;
  final String name;
  final Set<MinimalWord> words;

  const Tag({
    required this.id,
    required this.name,
    required this.words,
  });

  Tag copyWith({
    String? id,
    String? name,
    Set<MinimalWord>? words,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
      words: words ?? this.words,
    );
  }

  @override
  String toString() => 'Tag(id: $id, name: $name, words: $words)';

  @override
  bool operator ==(covariant Tag other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      setEquals(other.words, words);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ words.hashCode;
}
