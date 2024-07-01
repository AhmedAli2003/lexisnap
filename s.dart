void main() {
  final set = {1, 2};
  print(set.hashCode);
  set.add(3);
  print(set.hashCode);
}
