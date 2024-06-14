import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/data/repositories/tag_repository_impl.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/domain/entities/tag.dart';
import 'package:lexisnap/features/home/domain/repositories/tag_repository.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';

final allTagsProvider = StateProvider<List<MinimalTag>>((ref) => []);

final tagProvider = StateProvider<Tag?>((ref) => null);

final tagControllerProvider = Provider<TagController>(
  (ref) => TagController(
    ref: ref,
    repository: ref.read(tagRepositoryProvider),
  ),
);

class TagController extends StateNotifier<TagControllerState> {
  TagController({
    required Ref ref,
    required TagRepository repository,
  })  : _ref = ref,
        _repository = repository,
        super(TagControllerState());

  final Ref _ref;
  final TagRepository _repository;

  void getAllTags(BuildContext context, int page) async {
    state.getAllTagsLoading = true;
    final either = await _repository.getAllTags(page: page);
    state.getAllTagsLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (tags) => _ref.read(allTagsProvider.notifier).update((state) {
        state.addAll(tags);
        return state;
      }),
    );
  }

  void getTagById(BuildContext context, String id) async {
    state.getTagByIdLoading = true;
    final either = await _repository.getTagById(id);
    state.getTagByIdLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (tag) => _ref.read(tagProvider.notifier).update((_) => tag),
    );
  }

  void createTag(BuildContext context, Tag tag) async {
    state.createTagLoading = true;
    final either = await _repository.createTag(tag);
    state.createTagLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (tag) => _ref.read(tagProvider.notifier).update((_) => tag),
    );
  }

  void updateTag(BuildContext context, MinimalTag tag) async {
    state.updateTagLoading = true;
    final either = await _repository.updateTag(tag);
    state.updateTagLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (tag) => _ref.read(tagProvider.notifier).update(
            (_) => Tag(
              id: tag.id,
              name: tag.name,
              words: [],
            ),
          ),
    );
  }

  void deleteTag(BuildContext context, String id) async {
    state.deleteTagLoading = true;
    final either = await _repository.deleteTag(id);
    state.deleteTagLoading = false;
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (_) => _ref.read(tagProvider.notifier).update((_) => null),
    );
  }
}

class TagControllerState {
  bool getAllTagsLoading;
  bool getTagByIdLoading;
  bool createTagLoading;
  bool updateTagLoading;
  bool deleteTagLoading;

  TagControllerState({
    this.getAllTagsLoading = false,
    this.getTagByIdLoading = false,
    this.createTagLoading = false,
    this.updateTagLoading = false,
    this.deleteTagLoading = false,
  });
}
