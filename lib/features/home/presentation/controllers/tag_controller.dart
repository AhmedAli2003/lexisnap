// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lexisnap/core/models/create_or_update_tag_request.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/features/home/data/repositories/tag_repository_impl.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/domain/entities/tag.dart';
import 'package:lexisnap/features/home/domain/repositories/tag_repository.dart';

final allTagsProvider = StateProvider<List<MinimalTag>>((ref) => []);

final tagProvider = StateProvider<Tag?>((ref) => null);

final tagControllerProvider = StateNotifierProvider<TagController, TagLoadingState>(
  (ref) => TagController(
    ref: ref,
    repository: ref.read(tagRepositoryProvider),
  ),
);

class TagController extends StateNotifier<TagLoadingState> {
  TagController({
    required Ref ref,
    required TagRepository repository,
  })  : _ref = ref,
        _repository = repository,
        super(const TagLoadingState());

  final Ref _ref;
  final TagRepository _repository;

  void getAllTags(BuildContext context, int page) async {
    state = state.copyWith(getAllTags: true);
    final either = await _repository.getAllTags(page: page);
    state = state.copyWith(getAllTags: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (tags) => _ref.read(allTagsProvider.notifier).update((state) {
        state.addAll(tags);
        return state;
      }),
    );
  }

  void getTagById(BuildContext context, String id) async {
    state = state.copyWith(getTagById: true);
    final either = await _repository.getTagById(id);
    state = state.copyWith(getTagById: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (tag) => _ref.read(tagProvider.notifier).update((_) => tag),
    );
  }

  void createTag(BuildContext context, CreateOrUpdateTagRequest tag) async {
    state = state.copyWith(createTag: true);
    final either = await _repository.createTag(tag);
    state = state.copyWith(createTag: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (tag) => _ref.read(tagProvider.notifier).update((_) => tag),
    );
  }

  void updateTag({
    required BuildContext context,
    required String id,
    required CreateOrUpdateTagRequest tag,
  }) async {
    state = state.copyWith(updateTag: true);
    final either = await _repository.updateTag(id, tag);
    state = state.copyWith(updateTag: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (tag) => _ref.read(tagProvider.notifier).update(
            (_) => Tag(
              id: tag.id,
              name: tag.name,
              words: {},
            ),
          ),
    );
  }

  void deleteTag(BuildContext context, String id) async {
    state = state.copyWith(getAllTags: true);
    final either = await _repository.deleteTag(id);
    state = state.copyWith(getAllTags: false);
    either.fold(
      (failure) => showSnackBar(context, failure.message),
      (_) => _ref.read(tagProvider.notifier).update((_) => null),
    );
  }
}

class TagLoadingState {
  final bool getAllTags;
  final bool getTagById;
  final bool createTag;
  final bool updateTag;
  final bool deleteTag;

  const TagLoadingState({
    this.getAllTags = false,
    this.getTagById = false,
    this.createTag = false,
    this.updateTag = false,
    this.deleteTag = false,
  });

  TagLoadingState copyWith({
    bool? getAllTags,
    bool? getTagById,
    bool? createTag,
    bool? updateTag,
    bool? deleteTag,
  }) {
    return TagLoadingState(
      getAllTags: getAllTags ?? this.getAllTags,
      getTagById: getTagById ?? this.getTagById,
      createTag: createTag ?? this.createTag,
      updateTag: updateTag ?? this.updateTag,
      deleteTag: deleteTag ?? this.deleteTag,
    );
  }
}
