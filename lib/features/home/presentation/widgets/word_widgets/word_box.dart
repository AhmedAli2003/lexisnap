import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/widgets/custom_text_field.dart';
import 'package:lexisnap/features/home/presentation/widgets/speak_icon.dart';

class WordBox extends ConsumerStatefulWidget {
  const WordBox({super.key});

  @override
  ConsumerState<WordBox> createState() => _WordBoxState();
}

class _WordBoxState extends ConsumerState<WordBox> {
  bool editWord = false;

  TextEditingController? controller;
  FocusNode? node;

  @override
  void dispose() {
    controller?.dispose();
    node?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final word = ref.watch(wordTextProvider);
    return editWord
        ? CustomTextField(
            controller: controller,
            focusNode: node!..requestFocus(),
            onEditingComplete: onEditingComplete,
          )
        : Row(
            children: [
              const Icon(Icons.menu_book_rounded),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => switchToEditWord(word),
                child: Text(
                  word,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              SpeakIcon(text: word),
            ],
          );
  }

  void switchToEditWord(String text) {
    controller = TextEditingController(text: text);
    node = FocusNode();
    editWord = true;
    setState(() {});
  }

  void onEditingComplete() {
    final text = controller!.text.trim();
    if (text.isEmpty) {
      showSnackBar(context, 'The word is empty');
      return;
    }
    ref.read(wordProvider.notifier).updateWordText(text);
    controller?.dispose();
    node?.dispose();
    editWord = false;
    setState(() {});
  }
}
