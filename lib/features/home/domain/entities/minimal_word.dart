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
}
