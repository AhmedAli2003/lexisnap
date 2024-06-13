class MinimalWord {
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
}
