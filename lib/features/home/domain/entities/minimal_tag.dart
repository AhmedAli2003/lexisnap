class MinimalTag {
  final String id;
  final String name;

  const MinimalTag({
    required this.id,
    required this.name,
  });

  MinimalTag copyWith({
    String? id,
    String? name,
  }) {
    return MinimalTag(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
