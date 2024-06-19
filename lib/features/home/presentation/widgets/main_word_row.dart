import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/custom_text_field.dart';
import 'package:lexisnap/features/home/presentation/widgets/speak_icon.dart';

class MainWordRow extends ConsumerStatefulWidget {
  const MainWordRow({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainWordRowState();
}

class _MainWordRowState extends ConsumerState<MainWordRow> {
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
    final word = ref.watch(wordProvider)!;
    controller.text = word.word;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.menu_book_rounded),
        const SizedBox(width: 12),
        Expanded(
          child: CustomTextField(
            controller: controller,
            focusNode: node,
            onEditingComplete: () {},
          ),
        ),
        SpeakIcon(text: word.word),
      ],
    );
  }
}
