import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lexisnap/features/home/presentation/pages/create_word_page.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/app_drawer.dart';
import 'package:lexisnap/features/home/presentation/widgets/home_header.dart';
import 'package:lexisnap/features/home/presentation/widgets/starting_welcome_widget.dart';

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
      appBar: AppBar(
        title: HomeHeader(name: user.name),
      ),
      body: allWordsLoading
          ? const Loading()
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 24,
                ),
                child: words.isEmpty
                    ? const StartingWelcomeWidget()
                    : ListView.builder(
                        itemCount: words.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(words[index].word),
                        ),
                      ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          GoRouter.of(context).goNamed(CreateWordPage.name);
        },
      ),
    );
  }
}
