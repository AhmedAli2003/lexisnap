// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lexisnap/core/theme/app_colors.dart';
// import 'package:lexisnap/features/home/domain/entities/minimal_word.dart';
// import 'package:lexisnap/features/home/presentation/controllers/word_controller.dart';
// import 'package:lexisnap/features/home/presentation/controllers/word_notifier.dart';
// import 'package:lexisnap/features/home/presentation/widgets/custom_text_field.dart';

// final searchControllerProvider = StateProvider.autoDispose<String?>((ref) => '');

// final selectedSynonymsProvider = StateProvider.autoDispose<List<MinimalWord>>((ref) => []);

// class SynonymsSheet extends ConsumerStatefulWidget {
//   final List<MinimalWord> syns;
//   const SynonymsSheet({
//     super.key,
//     required this.syns,
//   });

//   @override
//   ConsumerState<SynonymsSheet> createState() => _SynonymsSheetState();
// }

// class _SynonymsSheetState extends ConsumerState<SynonymsSheet> {
//   late final TextEditingController searchController;
//   late final FocusNode searchNode;
//   Timer? _debounce;

//   @override
//   void initState() {
//     super.initState();
//     searchController = TextEditingController();
//     searchNode = FocusNode();
//     Future.delayed(Duration.zero, () {
//       ref.read(selectedSynonymsProvider.notifier).state = widget.syns;
//     });
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     searchNode.dispose();
//     _debounce?.cancel();
//     super.dispose();
//   }

//   bool showSearchField = false;

//   @override
//   Widget build(BuildContext context) {
//     final searchQuery = ref.watch(searchControllerProvider);
//     final words = ref.watch(searchWordsProvider(searchQuery));
//     final selectedWords = ref.watch(selectedSynonymsProvider);
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       height: showSearchField ? 800 : 400,
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: const BoxDecoration(
//         color: AppColors.grey,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(12),
//           topRight: Radius.circular(12),
//         ),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (showSearchField)
//                   Expanded(
//                     child: CustomTextField(
//                       controller: searchController,
//                       focusNode: searchNode..requestFocus(),
//                       onEditingComplete: () {
//                         searchNode.unfocus();
//                         setState(() {
//                           showSearchField = false;
//                         });
//                       },
//                       onChanged: _onSearchChanged,
//                       hint: 'Search about synonyms',
//                       hintStyle: HintStyle.small,
//                     ),
//                   ),
//                 if (!showSearchField)
//                   const Text(
//                     'Select synonyms',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 if (!showSearchField)
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         showSearchField = true;
//                       });
//                     },
//                     icon: const Icon(Icons.search_rounded),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Wrap(
//               spacing: 8.0,
//               runSpacing: 8.0,
//               children: words
//                   .map(
//                     (word) => GestureDetector(
//                       onTap: () {
//                         ref.read(selectedSynonymsProvider.notifier).update((state) {
//                           if (state.contains(word)) {
//                             state.remove(word);
//                             ref.read(wordProvider.notifier).removeSynonym(word);
//                           } else {
//                             state.add(word);
//                             ref.read(wordProvider.notifier).addSynonym(word);
//                           }
//                           return [...state];
//                         });
//                       },
//                       child: Chip(
//                         label: Text(word.word),
//                         backgroundColor: selectedWords.contains(word) ? AppColors.green : null,
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _onSearchChanged(String query) {
//     if (_debounce?.isActive ?? false) _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 300), () {
//       ref.read(searchControllerProvider.notifier).state = query.trim();
//     });
//   }
// }
