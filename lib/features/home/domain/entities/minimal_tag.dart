class MinimalTag {
  final String id;
  final String name;

  const MinimalTag({
    required this.id,
    required this.name,
  });

  const MinimalTag.empty({
    this.id = '',
    this.name = '',
  });

  bool get isEmpty => this == const MinimalTag.empty();

  MinimalTag copyWith({
    String? id,
    String? name,
  }) {
    return MinimalTag(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(covariant MinimalTag other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'MinimalTag(id: $id, name: $name)';
}
