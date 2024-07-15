import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/text-styles/delius.dart';
import 'package:lexisnap/core/theme/text-styles/lato.dart';
import 'package:lexisnap/core/theme/text-styles/merriweather.dart';
import 'package:lexisnap/core/theme/text-styles/montserrat.dart';
import 'package:lexisnap/core/theme/text-styles/nunito.dart';
import 'package:lexisnap/core/theme/text-styles/open_sans.dart';
import 'package:lexisnap/core/theme/text-styles/pacifico.dart';
import 'package:lexisnap/core/theme/text-styles/playfair_display.dart';
import 'package:lexisnap/core/theme/text-styles/poppins.dart';
import 'package:lexisnap/core/theme/text-styles/roboto.dart';
import 'package:lexisnap/features/settings/controllers/settings_controller.dart';
import 'package:lexisnap/features/settings/controllers/text_families.dart';

final fontFamilyProvider = StateProvider<TextFamily>((ref) {
  return ref.read(settingsControllerProvider).getTextFamily();
});

class SettingsPage extends ConsumerStatefulWidget {
  static const String path = 'settings';
  static const String name = 'Settings-Page';
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final font = ref.watch(fontFamilyProvider);
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          text: 'Choose a font',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: TextFamily.values.map((textFamily) {
            return RadioListTile<TextFamily>(
              value: textFamily,
              groupValue: font,
              onChanged: (value) async {
                if (value != null) {
                  await ref.read(settingsControllerProvider).setTextFamily(
                        context: context,
                        textFamily: value,
                      );
                  ref.read(fontFamilyProvider.notifier).update((state) => value);
                }
              },
              title: Text(
                'Hello From LexiSnap Team! (${textFamily.toString().split('.').last})',
                style: getTextStyle(textFamily, 18, FontWeight.w500),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  TextStyle getTextStyle(TextFamily textFamily, double fontSize, FontWeight fontWeight) {
    switch (textFamily) {
      case TextFamily.delius:
        return delius(fontSize: fontSize, fontWeight: fontWeight);
      case TextFamily.lato:
        return lato(fontSize: fontSize, fontWeight: fontWeight);
      case TextFamily.merriweather:
        return merriweather(fontSize: fontSize, fontWeight: fontWeight);
      case TextFamily.montserrat:
        return montserrat(fontSize: fontSize, fontWeight: fontWeight);
      case TextFamily.nunito:
        return nunito(fontSize: fontSize, fontWeight: fontWeight);
      case TextFamily.openSans:
        return openSans(fontSize: fontSize, fontWeight: fontWeight);
      case TextFamily.pacifico:
        return pacifico(fontSize: fontSize, fontWeight: fontWeight);
      case TextFamily.playfairDisplay:
        return playfairDisplay(fontSize: fontSize, fontWeight: fontWeight);
      case TextFamily.poppins:
        return poppins(fontSize: fontSize, fontWeight: fontWeight);
      case TextFamily.roboto:
        return roboto(fontSize: fontSize, fontWeight: fontWeight);
      default:
        return roboto(fontSize: fontSize, fontWeight: fontWeight);
    }
  }
}
