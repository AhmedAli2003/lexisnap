import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/models/create_word_request.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/pages/create-update-page/create_and_update_word_page.dart';
import 'package:lexisnap/features/home/presentation/widgets/cancel_button.dart';
import 'package:lexisnap/features/home/presentation/widgets/custom_text_field.dart';

class CreatePageScaffold extends ConsumerStatefulWidget {
  const CreatePageScaffold({super.key});

  @override
  ConsumerState<CreatePageScaffold> createState() => _CreatePageScaffoldState();
}

class _CreatePageScaffoldState extends ConsumerState<CreatePageScaffold> {
  late final TextEditingController controller;
  late final FocusNode node;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    node = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CancelButton(),
        leadingWidth: 92,
        centerTitle: true,
        title: const AppText(text: 'Add a new word'),
      ),
      body: ref.watch(wordControllerProvider).createWord
          ? const Loading() // tloading while the word is creating
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: controller,
                focusNode: node,
                hint: 'Write the word here...',
                onEditingComplete: onEditingComplete,
              ),
            ),
    );
  }

  void onEditingComplete() async {
    // Wait till the word is created, in this time loading will appear
    final word = await ref.read(wordControllerProvider.notifier).createWord(
          context,
          CreateWordRequest(
            word: controller.text.trim(),
          ),
        );

    // Check if the word creation is successful
    if (word == null) {
      // The word creation failed, so we need to pop to home page
      // ignore: use_build_context_synchronously
      GoRouter.of(context).pop();
    }
    // After the word is created, update page scaffold will appear
    ref.read(isCreateProvider.notifier).state = false;
  }
}
