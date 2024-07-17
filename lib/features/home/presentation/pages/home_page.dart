import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/home_page_words_provider.dart';
import 'package:lexisnap/features/home/presentation/controllers/home_search_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/tag_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
import 'package:lexisnap/features/home/presentation/pages/create-update-page/create_and_update_word_page.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/pages/view_word_page.dart';
import 'package:lexisnap/features/home/presentation/widgets/drawer/app_drawer.dart';
import 'package:lexisnap/features/home/presentation/widgets/home_page_app_bar.dart';
import 'package:lexisnap/features/home/presentation/widgets/starting_welcome_widget.dart';
import 'package:lexisnap/features/home/presentation/widgets/word_tile_widget.dart';

class HomePage extends ConsumerWidget {
  static const String path = '/home';
  static const String name = 'Home-Page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final words = ref.watch(homePageWordsProvider);
    final allWordsLoading = ref.watch(wordControllerProvider).getAllWords;
    return Scaffold(
      drawer: const AppDrawer(),
      body: allWordsLoading
          ? const Loading()
          : words.isEmpty && ref.watch(homeSearchControllerProvider) == null
              ? const StartingWelcomeWidget()
              : SafeArea(
                  child: RefreshIndicator.adaptive(
                    onRefresh: () async {
                      ref.read(wordControllerProvider.notifier).getAllWords(context, 1);
                      ref.read(wordControllerProvider.notifier).getWordsOverview(context);
                      ref.read(tagControllerProvider.notifier).getAllTags(context, 1);
                      ref.read(wordsSortingProvider.notifier).update((_) => Sorting.dateDesc);
                    },
                    child: CustomScrollView(
                      slivers: [
                        HomePageAppBar(user: user),
                        SliverFixedExtentList.builder(
                          itemExtent: 72,
                          itemCount: words.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: WordTileWidget(
                              word: words[index],
                              onTap: () {
                                ref.read(wordProvider.notifier).updateWordObject(words[index]);
                                GoRouter.of(context).pushNamed(ViewWordPage.name);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigate(context),
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 4, 112, 201),
                Colors.lightBlueAccent,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void navigate(BuildContext context) {
    GoRouter.of(context).goNamed(CreateOrUpdateWordPage.name);
  }
}
