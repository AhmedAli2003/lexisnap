import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lexisnap/core/models/create_statement_request.dart';
// import 'package:lexisnap/core/models/update_statement_request.dart';
// import 'package:lexisnap/core/models/update_word_request.dart';
import 'package:lexisnap/features/auth/presentation/controllers/auth_controller.dart';
import 'package:lexisnap/features/home/presentation/controllers/statement_controller.dart';
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
                        ref
                            .read(statementControllerProvider.notifier)
                            .deleteStatement(context, '666cb02ae15c6a6e9eca5a57');

                        // ref.read(statementControllerProvider.notifier).updateStatement(
                        //       context: context,
                        //       id: '666cb02ae15c6a6e9eca5a57',
                        //       statement: const UpdateStatementRequest(
                        //         text: 'THIS IS AMAZING!!!!',
                        //         translation: 'هذا رائع!!',
                        //       ),
                        //     );

                        // ref
                        //     .read(statementControllerProvider.notifier)
                        //     .getStatementById(context, '666cb02ae15c6a6e9eca5a57');

                        // ref.read(statementControllerProvider.notifier).createStatement(
                        //       context,
                        //       const CreateStatementRequest(
                        //         text: 'That is amazing!!',
                        //         word: '666c379fabf43e912cef9181',
                        //       ),
                        //     );

                        // ref.read(wordControllerProvider.notifier).getWordsOverview(context);

                        // ref.read(wordControllerProvider.notifier).getAllWords(context, 1);

                        // ref.read(wordControllerProvider.notifier).getWordById(context, '666c379fabf43e912cef9181');

                        // ref.read(wordControllerProvider.notifier).deleteWord(context, '666c3b4e91f9dfc1a09ad7de');

                        // ref.read(wordControllerProvider.notifier).updateWord(
                        //       context: context,
                        //       id: '666c3bbb1b5f5e7097db9b2d',
                        //       word: const UpdateWordRequest(
                        //         word: 'Mohammed',
                        //         note: 'Small Update',
                        //         definitions: [],
                        //         translations: [],
                        //         tags: [],
                        //         statements: [],
                        //         synonyms: [],
                        //         opposites: [],
                        //       ),
                        //     );

                        // ref.read(wordControllerProvider.notifier).createWord(
                        //       context,
                        //       const CreateWordRequest(
                        //         word: 'Ahmed',
                        //         definitions: ['definitions'],
                        //         translations: ['جميل'],
                        //       ),
                        //     );
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
