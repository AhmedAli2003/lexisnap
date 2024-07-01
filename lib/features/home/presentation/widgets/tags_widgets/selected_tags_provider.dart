import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';

final selectedTagsProvider = StateNotifierProvider<SelectedTagsNotifier, Set<MinimalTag>>(
  (ref) => SelectedTagsNotifier(ref),
);

class SelectedTagsNotifier extends StateNotifier<Set<MinimalTag>> {
  final Ref _ref;
  SelectedTagsNotifier(Ref ref)
      : _ref = ref,
        super(const <MinimalTag>{});

  void addTag(MinimalTag tag) {
    _ref.read(wordProvider.notifier).addTag(tag);
    state = {...state, tag};
  }

  void removeTag(MinimalTag tag) {
    _ref.read(wordProvider.notifier).removeTag(tag);
    state = {...state..remove(tag)};
  }
}
