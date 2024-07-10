import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/home/presentation/widgets/cancel_button.dart';
import 'package:lexisnap/features/home/presentation/widgets/definitions_widgets/definitions_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/opposites_widgets/opposites_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/save_word_icon_button.dart';
import 'package:lexisnap/features/home/presentation/widgets/statements_widgets/statements_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/synonyms_widgets/synonyms_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/tags_widgets/tag_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/translations_widgets/translations_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/word_widgets/word_box.dart';

class UpdatePageScaffold extends StatelessWidget {
  const UpdatePageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CancelButton(),
        leadingWidth: 72,
        centerTitle: true,
        title: const AppText(text: 'Wealth the word'),
        actions: const [SaveWordIconButton()],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              WordBox(),
              TranslationsBox(),
              DefinitionsBox(),
              StatementsBox(),
              TagsBox(),
              SynonymsBox(),
              OppositesBox(),
            ],
          ),
        ),
      ),
    );
  }
}
