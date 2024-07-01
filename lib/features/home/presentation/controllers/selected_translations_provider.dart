import 'package:flutter/foundation.dart' show setEquals;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedTranslationsProvider =
    StateNotifierProvider.autoDispose<SelectedTranslationsNotifier, SelectedTranslationsState>(
  (ref) => SelectedTranslationsNotifier(),
);

class SelectedTranslationsState {
  const SelectedTranslationsState([this._translations = const {}]);

  final Set<String> _translations;

  Set<String> get translations => _translations;

  int get length => _translations.length;

  bool get isEmpty => _translations.isEmpty;

  bool get isNotEmpty => _translations.isNotEmpty;

  SelectedTranslationsState copyWith({
    Set<String>? translations,
  }) {
    return SelectedTranslationsState(
      translations ?? _translations,
    );
  }

  @override
  bool operator ==(covariant SelectedTranslationsState other) {
    if (identical(this, other)) return true;

    return setEquals(other._translations, _translations);
  }

  @override
  int get hashCode => _translations.hashCode;
}

class SelectedTranslationsNotifier extends StateNotifier<SelectedTranslationsState> {
  SelectedTranslationsNotifier() : super(const SelectedTranslationsState());

  bool contains(String translation) {
    return state.translations.contains(translation);
  }

  void add(String translation) {
    state = state.copyWith(translations: {...state.translations, translation});
  }

  void remove(String translation) {
    state = state.copyWith(translations: {...state.translations..remove(translation)});
  }

  void clear() {
    state = const SelectedTranslationsState();
  }

  bool get isEmpty => state.isEmpty;

  bool get isNotEmpty => state.isNotEmpty;

  int get length => state.length;
}
