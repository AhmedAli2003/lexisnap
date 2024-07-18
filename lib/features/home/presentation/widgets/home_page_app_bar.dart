import 'dart:async';
import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/auth/domain/entities/app_user.dart';
import 'package:lexisnap/features/home/presentation/controllers/home_page_words_provider.dart';
import 'package:lexisnap/features/home/presentation/controllers/home_search_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/home_header.dart';
import 'package:lexisnap/features/settings/controllers/settings_controller.dart';

class HomePageAppBar extends ConsumerStatefulWidget {
  const HomePageAppBar({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  ConsumerState<HomePageAppBar> createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends ConsumerState<HomePageAppBar> {
  bool search = false;

  TextEditingController? controller;
  FocusNode? node;

  Timer? _debounce;

  @override
  void dispose() {
    controller?.dispose();
    node?.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = ref.watch(settingsControllerProvider).getTextStyle;
    return SliverAppBar(
      title: search
          ? TextField(
              controller: controller,
              focusNode: node?..requestFocus(),
              cursorColor: AppColors.blue,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search about words...',
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.blue),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      search = false;
                    });
                    controller?.dispose();
                    node?.dispose();
                    ref.read(homeSearchControllerProvider.notifier).clear();
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
              ),
              style: textStyle(),
              onChanged: onChanged,
            )
          : HomeHeader(name: firstName),
      automaticallyImplyLeading: !search,
      actions: search
          ? null
          : [
              IconButton(
                onPressed: () {
                  setState(() {
                    search = true;
                  });
                  controller = TextEditingController();
                  node = FocusNode();
                },
                icon: const Icon(Icons.search_rounded),
              ),
              const SortByDateIcon(),
              const SortAlphabaticalIcon(),
            ],
    );
  }

  String get firstName => widget.user.name.substring(0, widget.user.name.indexOf(' '));

  void onChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(homeSearchControllerProvider.notifier).search(text);
    });
  }
}

class SortAlphabaticalIcon extends ConsumerWidget {
  const SortAlphabaticalIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sorting = ref.watch(wordsSortingProvider);
    return IconButton(
      onPressed: () {
        if (sorting == Sorting.alphaAsc) {
          ref.read(wordsSortingProvider.notifier).update((_) => Sorting.alphaDesc);
        } else {
          ref.read(wordsSortingProvider.notifier).update((_) => Sorting.alphaAsc);
        }
      },
      icon: const Icon(Icons.sort_by_alpha_rounded),
    );
  }
}

class SortByDateIcon extends ConsumerStatefulWidget {
  const SortByDateIcon({
    super.key,
  });

  @override
  ConsumerState<SortByDateIcon> createState() => _SortByDateIconState();
}

class _SortByDateIconState extends ConsumerState<SortByDateIcon> {
  @override
  Widget build(BuildContext context) {
    final sorting = ref.watch(wordsSortingProvider);
    return IconButton(
      onPressed: () {
        if (sorting == Sorting.dateDesc) {
          ref.read(wordsSortingProvider.notifier).update((_) => Sorting.dateAsc);
        } else {
          ref.read(wordsSortingProvider.notifier).update((_) => Sorting.dateDesc);
        }
        setState(() {});
      },
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transformAlignment: Alignment.center,
        transform: Matrix4.identity()..rotateX(sorting == Sorting.dateAsc ? pi : 0),
        child: const Icon(Icons.sort_rounded),
      ),
    );
  }
}
