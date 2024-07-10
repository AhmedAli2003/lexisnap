import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';

final selectedOppositesProvider = StateNotifierProvider.autoDispose<SelectedOppositesNotifier, Set<MinimalWord>>(
  (ref) {
    final link = ref.keepAlive();
    Future.delayed(const Duration(milliseconds: 100), () {
      link.close();
    });
    return SelectedOppositesNotifier(ref);
  },
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

  void addAll(Set<MinimalWord> opposites) {
    state = {...opposites};
  }

  void removeOpposite(MinimalWord opposite) {
    _ref.read(wordProvider.notifier).removeOpposite(opposite);
    state = {...state..remove(opposite)};
  }
}
