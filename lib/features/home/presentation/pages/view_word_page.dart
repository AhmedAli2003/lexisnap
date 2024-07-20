import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/pages/create-update-page/update_word_page.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_definitions_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_opposites_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_statements_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_synonyms_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_tags_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_translations_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/display_word_boxes/display_word_text_box.dart';
import 'package:lexisnap/features/home/presentation/widgets/view_page_menu.dart';

class ViewWordPage extends ConsumerWidget {
  static const String path = 'view-word';
  static const String name = 'View-Word-Page';

  const ViewWordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(wordProvider);
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: 'Word Details'),
        actions: const [ViewPageMenu()],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: DisplaySynonymsBox()),
                    Expanded(child: DisplayOppositesBox()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => navigateToUpdate(context),
      //   child: const Icon(Icons.edit_rounded),
      // ),
    );
  }

  void navigateToUpdate(BuildContext context) {
    GoRouter.of(context).pushNamed(UpdateWordPage.name);
  }
}
