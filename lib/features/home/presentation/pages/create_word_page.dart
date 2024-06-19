import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/models/create_word_request.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/cancel_and_pop_button.dart';
import 'package:lexisnap/features/home/presentation/widgets/custom_text_field.dart';
import 'package:lexisnap/features/home/presentation/widgets/definitions_section_widget.dart';
import 'package:lexisnap/features/home/presentation/widgets/field_title_card.dart';
import 'package:lexisnap/features/home/presentation/widgets/app_bar_title.dart';
import 'package:lexisnap/features/home/presentation/widgets/main_word_row.dart';
import 'package:lexisnap/features/home/presentation/widgets/save_word_icon_button.dart';
import 'package:lexisnap/features/home/presentation/widgets/statements_section_widget.dart';
import 'package:lexisnap/features/home/presentation/widgets/tags_card.dart';
import 'package:lexisnap/features/home/presentation/widgets/translation_field_widget.dart';

class CreateWordPage extends ConsumerStatefulWidget {
  static const String path = 'create-word';
  static const String name = 'Create-Word-Page';
  const CreateWordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateWordPageState();
}

class _CreateWordPageState extends ConsumerState<CreateWordPage> {
  late final TextEditingController wordController;
  late final FocusScopeNode globalNode;
  late final FocusNode wordFocusNode;

  @override
  void initState() {
    super.initState();
    wordController = TextEditingController();
    globalNode = FocusScopeNode();
    wordFocusNode = FocusNode();
    wordFocusNode.requestFocus();
  }

  @override
  void dispose() {
    wordController.dispose();
    wordFocusNode.dispose();
    globalNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final word = ref.watch(wordProvider);
    final wordLoadingState = ref.watch(wordControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: 72,
        leading: const CancelAndPopButton(),
        title: const AppBarTitle(title: 'Add a new word'),
        actions: word != null ? const [SaveWordIconButton()] : null,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FocusScope(
              node: globalNode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: wordLoadingState.createWord || wordLoadingState.updateWord
                    ? const [Loading()]
                    : word == null
                        ? [
                            CustomTextField(
                              controller: wordController,
                              hint: 'Write the word',
                              focusNode: wordFocusNode,
                              onEditingComplete: createWord,
                            )
                          ]
                        : [
                            const MainWordRow(),
                            const SizedBox(height: 12),
                            const TranslationFieldWidget(),
                            const DefinitionsSectionWidget(),
                            const StatementsSectionWidget(),
                            Row(
                              children: [
                                const FieldTitleCard(title: 'Tags'),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const TagsDialog(),
                                    );
                                  },
                                  icon: const Icon(Icons.add_rounded),
                                ),
                              ],
                            ),
                            Wrap(
                              alignment: WrapAlignment.start,
                              children: [
                                for (final tag in word.tags)
                                  TagCard(
                                    tag: tag,
                                    fromDialog: false,
                                  ),
                              ],
                            ),
                          ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createWord() {
    wordFocusNode.unfocus();
    final word = wordController.text.trim();
    if (word.length < 2) {
      showSnackBar(context, 'Word Length must be 2 characters at least');
      return;
    }
    ref.read(wordControllerProvider.notifier).createWord(context, CreateWordRequest(word: word));
  }
}
