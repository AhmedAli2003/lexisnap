import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/models/create_word_request.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';

class HomePage extends ConsumerWidget {
  static const String path = '/home';
  static const String name = 'Home-Page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(builder: (context, ref, child) {
              final state = ref.watch(wordControllerProvider);
              return ElevatedButton(
                onPressed: state.createWordLoading
                    ? null
                    : () {
                        // ref.read(wordControllerProvider.notifier).updateWord(
                        //       context,
                        //       const Word(
                        //         id: '666c3457abf43e912cef9172',
                        //         word: 'Good Good',
                        //         definitions: ['Word to impress someone'],
                        //         tags: [],
                        //         translations: ['جميل'],
                        //         statements: [],
                        //         synonyms: [],
                        //         opposites: [],
                        //         note: 'No notes now',
                        //       ),
                        //     );

                        ref.read(wordControllerProvider.notifier).createWord(
                              context,
                              const CreateWordRequest(
                                word: 'Ahmed',
                                definitions: ['definitions'],
                                translations: ['جميل'],
                              ),
                            );
                      },
                child: const Text('Create a Word'),
              );
            }),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).signOut(context);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
