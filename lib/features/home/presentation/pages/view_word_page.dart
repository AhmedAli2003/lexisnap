import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_definitions_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_opposites_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_statements_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_synonyms_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_tags_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_translations_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_word_text_box.dart';

class ViewWordPage extends StatelessWidget {
  static const String path = 'view-word';
  static const String name = 'View-Word-Page';

  const ViewWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Details'),
        actions: [
          //TODO: drop down items for update and delete
        ],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DisplayWordTextBox(),
                SizedBox(height: 20),
                DisplayTranslationsBox(),
                DisplayDifinitionsBox(),
                DisplayStatementsBox(),
                DisplayTagsBox(),
                DisplaySynonymsBox(),
                DisplayOppositesBox(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO: navigate to update word page
          GoRouter.of(context);
        },
        child: const Icon(Icons.edit_rounded),
      ),
    );
  }
}
