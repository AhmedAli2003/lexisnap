// ignore_for_file: public_member_api_docs, sort_constructors_first
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

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
