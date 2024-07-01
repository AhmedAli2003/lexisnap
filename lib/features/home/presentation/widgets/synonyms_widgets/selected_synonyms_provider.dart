import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';

final selectedSynonymsProvider = StateNotifierProvider<SelectedSynonymsNotifier, Set<MinimalWord>>(
  (ref) => SelectedSynonymsNotifier(ref),
);

class SelectedSynonymsNotifier extends StateNotifier<Set<MinimalWord>> {
  final Ref _ref;
  SelectedSynonymsNotifier(Ref ref)
      : _ref = ref,
        super(const <MinimalWord>{});

  void addSynonym(MinimalWord synonym) {
    _ref.read(wordProvider.notifier).addSynonym(synonym);
    state = {...state, synonym};
  }

  void removeSynonym(MinimalWord synonym) {
    _ref.read(wordProvider.notifier).removeSynonym(synonym);
    state = {...state..remove(synonym)};
  }
}
