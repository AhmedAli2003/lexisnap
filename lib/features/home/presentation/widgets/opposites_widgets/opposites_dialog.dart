import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/features/home/presentation/controllers/search_controller.dart';
import 'package:lexisnap/features/home/presentation/widgets/custom_text_field.dart';
import 'package:lexisnap/features/home/presentation/widgets/opposites_widgets/opposite_widget.dart';

class OppositesDialog extends ConsumerStatefulWidget {
  const OppositesDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OppositesDialogState();
}

class _OppositesDialogState extends ConsumerState<OppositesDialog> {
  late final TextEditingController searchController;
  late final FocusNode searchNode;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchNode = FocusNode();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final opposites = ref.watch(searchControllerProvider);
    return Container(
      height: 600,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.grey,
            Color.fromRGBO(39, 41, 48, 0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: searchController,
              focusNode: searchNode,
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.white,
              ),
              hint: 'Search about opposites...',
              hintStyle: HintStyle.small,
              onChanged: onChanged,
            ),
            const SizedBox(height: 12),
            Wrap(
              children: opposites
                  .map(
                    (op) => OppositeWidget(
                      opposite: op,
                      fromDialog: true,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  void onChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(searchControllerProvider.notifier).search(text);
    });
  }
}
