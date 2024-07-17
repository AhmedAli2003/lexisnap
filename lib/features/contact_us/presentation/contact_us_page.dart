import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/text-styles/roboto.dart';
import 'package:lexisnap/features/contact_us/presentation/box_text_field.dart';
import 'package:lexisnap/features/contact_us/presentation/text.dart';

class ContactUsPage extends StatelessWidget {
  static const String path = 'contact-us';
  static const String name = 'Contact-Us-Page';
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: 'Contact Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$arabicTextWelcome\n',
                  textDirection: TextDirection.rtl,
                  style: roboto(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '$arabicTextPartOne\n',
                  textDirection: TextDirection.rtl,
                  style: roboto(),
                ),
                Text(
                  '$arabicTextPartTwo\n',
                  textDirection: TextDirection.rtl,
                  style: roboto(),
                ),
                Text(
                  '$arabicTextPartThree\n',
                  textDirection: TextDirection.rtl,
                  style: roboto(),
                ),
                Text(
                  arabicTextThanks,
                  textDirection: TextDirection.rtl,
                  style: roboto(),
                ),
              ],
            ),
            const Divider(
              height: 30,
            ),
            Text(
              englishTextWelcome,
              style: roboto(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              englishTextPartOne,
              style: roboto(),
            ),
            Text(
              englishTextPartTwo,
              style: roboto(),
            ),
            Text(
              englishTextPartThree,
              style: roboto(),
            ),
            Text(
              englishTextThanks,
              style: roboto(),
            ),
            const SizedBox(height: 12),
            const BoxTextField(),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
