import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lexisnap/features/home/presentation/pages/create-update-page/create_and_update_word_page.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/drawer/app_drawer.dart';
import 'package:lexisnap/features/home/presentation/widgets/home_header.dart';
import 'package:lexisnap/features/home/presentation/widgets/starting_welcome_widget.dart';
import 'package:lexisnap/features/home/presentation/widgets/word_tile_widget.dart';

class HomePage extends ConsumerWidget {
  static const String path = '/home';
  static const String name = 'Home-Page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final words = ref.watch(allWordsProvider);
    final allWordsLoading = ref.watch(wordControllerProvider).getAllWords;
    return Scaffold(
      drawer: const AppDrawer(),
      body: allWordsLoading
          ? const Loading()
          : words.isEmpty
              ? const StartingWelcomeWidget()
              : SafeArea(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        title: HomeHeader(name: user.name),
                      ),
                      SliverList.builder(
                        itemCount: words.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: WordTileWidget(ref: ref, word: words[index]),
                        ),
                      ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigate(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void navigate(BuildContext context) {
    GoRouter.of(context).goNamed(CreateOrUpdateWordPage.name);
  }
}
