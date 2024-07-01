import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/features/home/presentation/pages/create-update-page/create_page_scaffold.dart';
import 'package:lexisnap/features/home/presentation/pages/create-update-page/update_page_scaffold.dart';

// This provider to switch between create and update UI
final isCreateProvider = StateProvider<bool>((_) => true);

// This implementation is used because the create and update word
// have similar UI
class CreateOrUpdateWordPage extends ConsumerWidget {
  static const String path = 'create-or-update-word';
  static const String name = 'Create-Or-Update-Word-Page';
  const CreateOrUpdateWordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(isCreateProvider) ? const CreatePageScaffold() : const UpdatePageScaffold();
  }
}

