class Statement {
  final String id;
  final String text;
  final String wordId;
  final String translation;

  const Statement({
    required this.id,
    required this.text,
    required this.wordId,
    required this.translation,
  });

  Statement copyWith({
    String? id,
    String? text,
    String? wordId,
    String? translation,
  }) {
    return Statement(
      id: id ?? this.id,
      text: text ?? this.text,
      wordId: wordId ?? this.wordId,
      translation: translation ?? this.translation,
    );
  }

  

  @override
  bool operator ==(covariant Statement other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.text == text &&
      other.wordId == wordId &&
      other.translation == translation;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      text.hashCode ^
      wordId.hashCode ^
      translation.hashCode;
  }

  @override
  String toString() {
    return 'Statement(id: $id, text: $text, wordId: $wordId, translation: $translation)';
  }
}
