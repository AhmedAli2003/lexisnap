import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/logic.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/text-styles/roboto.dart';
import 'package:lexisnap/features/contact_us/contact.dart';
import 'package:lexisnap/features/contact_us/contact_us_controller.dart';

class BoxTextField extends ConsumerStatefulWidget {
  const BoxTextField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BoxTextFieldState();
}

class _BoxTextFieldState extends ConsumerState<BoxTextField> {
  late final TextEditingController controller;
  late final FocusNode node;

  TextDirection textDirection = TextDirection.ltr;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    node = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(contactUsControllerProvider);

    return Column(
      children: [
        TextField(
          controller: controller,
          focusNode: node,
          minLines: 8,
          maxLines: 100,
          textDirection: textDirection,
          decoration: InputDecoration(
            hintStyle: roboto(),
            hintText: 'Write what you want...',
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(),
          ),
          style: roboto(),
          onChanged: (value) {
            setState(() {
              textDirection = isEnglish(value.trim()) ? TextDirection.ltr : TextDirection.rtl;
            });
          },
        ),
        const SizedBox(height: 20),
        Center(
          child: GestureDetector(
            onTap: loading
                ? () {}
                : () async {
                    final text = controller.text.trim();
                    if (text.length < 2) {
                      showSnackBar(context, 'Please write a message');
                      return;
                    }
                    await ref.read(contactUsControllerProvider.notifier).sendContact(
                          context,
                          Contact(text: text),
                        );
                    controller.clear();
                    node.unfocus();
                  },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.deepPurpleAccent,
                    Color.fromARGB(255, 171, 151, 226),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: loading
                  ? const Loading()
                  : const GradientText(
                      text: 'Send',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white70,
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
