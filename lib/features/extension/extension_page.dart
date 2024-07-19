import 'package:flutter/material.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/text-styles/roboto.dart';
import 'package:lexisnap/features/extension/text.dart';

class ExtensionPage extends StatelessWidget {
  static const String path = 'extension-page';
  static const String name = 'Extension-Page';
  const ExtensionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: 'Our Extension !!'),
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
                  '$discoverExtensionArabic\n',
                  textDirection: TextDirection.rtl,
                  style: roboto(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '$extensionPartOneArabic\n',
                  textDirection: TextDirection.rtl,
                  style: roboto(),
                ),
                FittedBox(
                  child: Text(
                    '$extensionPartTwoArabic\n',
                    textDirection: TextDirection.rtl,
                    style: roboto(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  '$extensionPartThreeArabic\n',
                  textDirection: TextDirection.rtl,
                  style: roboto(),
                ),
                RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: t1Arabic,
                        style: roboto(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: '$st1Arabic\n',
                      ),
                    ],
                  ),
                ),
                RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: t2Arabic,
                        style: roboto(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: '$st2Arabic\n',
                      ),
                    ],
                  ),
                ),
                RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: t3Arabic,
                        style: roboto(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: '$st3Arabic\n',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              height: 30,
            ),
            Text(
              '$discoverExtensionEnglish\n',
              style: roboto(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '$extensionPartOneEnglish\n',
              style: roboto(),
            ),
            FittedBox(
              child: Text(
                '$extensionPartTwoEnglish\n',
                style: roboto(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              '$extensionPartThreeEnglish\n',
              style: roboto(),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: t1English,
                    style: roboto(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: '$st1English\n',
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: t2English,
                    style: roboto(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: '$st2English\n',
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: t3English,
                    style: roboto(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: '$st3English\n',
                  ),
                ],
              ),
            ),
            const Divider(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  howToUseArabic,
                  textDirection: TextDirection.rtl,
                  style: roboto(fontWeight: FontWeight.bold),
                ),
                Text(
                  '$howToUsePArabic\n',
                  textDirection: TextDirection.rtl,
                  style: roboto(),
                ),
              ],
            ),
            Text(
              howToUseEnglish,
              style: roboto(fontWeight: FontWeight.bold),
            ),
            Text(
              '$howToUsePEnglish\n',
              style: roboto(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: installTheExtensionTArabic,
                      style: roboto(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: installTheExtensionSArabic,
                      style: roboto(),
                    ),
                  ],
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: installTheExtensionTEnglish,
                    style: roboto(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: installTheExtensionSEnglish,
                    style: roboto(),
                  ),
                ],
              ),
            ),
            const Center(
              child: FlutterLogo(size: 128),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: signInTheExtensionTArabic,
                      style: roboto(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: signInTheExtensionSArabic,
                      style: roboto(),
                    ),
                  ],
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: signInTheExtensionTEnglish,
                    style: roboto(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: signInTheExtensionSEnglish,
                    style: roboto(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Image.asset('assets/images/extension/extension_sign_in.png'),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: selectTextExtensionTArabic,
                      style: roboto(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: selectTextExtensionSArabic,
                      style: roboto(),
                    ),
                  ],
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: selectTextExtensionTEnglish,
                    style: roboto(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: selectTextExtensionSEnglish,
                    style: roboto(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Image.asset('assets/images/extension/select_text.png'),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: addToExtensionTArabic,
                      style: roboto(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: addToExtensionSArabic,
                      style: roboto(),
                    ),
                  ],
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: addToExtensionTEnglish,
                    style: roboto(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: addToExtensionSEnglish,
                    style: roboto(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Image.asset('assets/images/extension/add.png'),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: saveExtensionTArabic,
                      style: roboto(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: saveExtensionSArabic,
                      style: roboto(),
                    ),
                  ],
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: saveExtensionTEnglish,
                    style: roboto(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: saveExtensionSEnglish,
                    style: roboto(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Image.asset('assets/images/extension/prepare_text.png'),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: manualExtensionTArabic,
                      style: roboto(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: manualExtensionSArabic,
                      style: roboto(),
                    ),
                  ],
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: manualExtensionTEnglish,
                    style: roboto(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: manualExtensionSEnglish,
                    style: roboto(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Image.asset('assets/images/extension/alt_add.png'),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
