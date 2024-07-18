import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/contact_us/contact.dart';
import 'package:lexisnap/features/contact_us/contact_us_repository.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';

final contactUsControllerProvider = StateNotifierProvider<ContactUsController, bool>((ref) {
  return ContactUsController(
    repository: ref.read(contactUsRepositoryProvider),
  );
});

class ContactUsController extends StateNotifier<bool> {
  final ContactUsRepository _repository;
  //final Ref _ref;

  ContactUsController({
    required ContactUsRepository repository,
    // required Ref ref,
  })  : // _ref = ref,
        _repository = repository,
        super(false);

  Future<void> sendContact(BuildContext context, Contact contact) async {
    state = true;
    final either = await _repository.sendContact(contact);
    state = false;
    either.fold(
      (failure) {
        showSnackBar(context, failure.message);
      },
      (_) {
        showSnackBar(context, 'Contact has been sent successfully!');
      },
    );
  }
}
