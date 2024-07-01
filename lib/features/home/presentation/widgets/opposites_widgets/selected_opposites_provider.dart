import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';

final selectedOppositesProvider = StateNotifierProvider<SelectedOppositesNotifier, Set<MinimalWord>>(
  (ref) => SelectedOppositesNotifier(ref),
);

class SelectedOppositesNotifier extends StateNotifier<Set<MinimalWord>> {
  final Ref _ref;
  SelectedOppositesNotifier(Ref ref)
      : _ref = ref,
        super(const <MinimalWord>{});

  void addOpposite(MinimalWord opposite) {
    _ref.read(wordProvider.notifier).addOpposite(opposite);
    state = {...state, opposite};
  }

  void removeOpposite(MinimalWord opposite) {
    _ref.read(wordProvider.notifier).removeOpposite(opposite);
    state = {...state..remove(opposite)};
  }
}
