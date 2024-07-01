class MinimalWord implements Comparable<MinimalWord> {
  final String id;
  final String word;

  const MinimalWord({
    required this.id,
    required this.word,
  });

  MinimalWord copyWith({
    String? id,
    String? word,
  }) {
    return MinimalWord(
      id: id ?? this.id,
      word: word ?? this.word,
    );
  }

  @override
  int compareTo(other) {
    return word.compareTo(other.word);
  }

  @override
  bool operator ==(covariant MinimalWord other) {
    if (identical(this, other)) return true;

    return other.id == id && other.word == word;
  }

  @override
  int get hashCode => id.hashCode ^ word.hashCode;

  @override
  String toString() => 'MinimalWord(id: $id, word: $word)';
}
