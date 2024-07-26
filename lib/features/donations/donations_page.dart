import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lexisnap/core/shared/ui_actions.dart';
import 'package:lexisnap/core/shared/widgets.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/core/theme/text-styles/roboto.dart';
import 'package:lexisnap/features/donations/text.dart';

class DonationsPage extends StatelessWidget {
  static const String path = 'donations';
  static const String name = 'Donations-Page';

  const DonationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(text: 'Support Your App!'),
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
                  '$titleArabic\n',
                  textDirection: TextDirection.rtl,
                  style: roboto(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '$p1Arabic\n',
                  textDirection: TextDirection.rtl,
                  style: roboto(),
                ),
                Text(
                  '$p2Arabic\n',
                  textDirection: TextDirection.rtl,
                  style: roboto(),
                ),
                Text(
                  '$p3Arabic\n',
                  textDirection: TextDirection.rtl,
                  style: roboto(),
                ),
              ],
            ),
            const Divider(height: 30),
            Text(
              '$titleEnglish\n',
              style: roboto(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '$p1English\n',
              style: roboto(),
            ),
            Text(
              '$p2English\n',
              style: roboto(),
            ),
            Text(
              '$p3English\n',
              style: roboto(),
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ways To Support Us',
                  style: roboto(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'طرق لدعمنا',
                  textDirection: TextDirection.rtl,
                  style: roboto(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            ListTile(
              leading: const Icon(
                Icons.paypal_rounded,
                color: AppColors.blue,
                size: 30,
              ),
              title: Text(
                'PayPal',
                style: roboto(fontWeight: FontWeight.w600),
              ),
              trailing: IconButton(
                onPressed: () {
                  Clipboard.setData(
                    const ClipboardData(
                      text: 'https://www.paypal.com/paypalme/AfnanAl123',
                    ),
                  );
                  showSnackBar(context, 'https://www.paypal.com/paypalme/AfnanAl123 copied');
                },
                icon: const Icon(Icons.copy_rounded),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/svgs/usdt.svg',
                height: 30,
                width: 30,
                // ignore: deprecated_member_use
                color: const Color(0xFF50a98f),
              ),
              title: Text(
                'USDT TRC20 (Tron)',
                style: roboto(fontWeight: FontWeight.w600),
              ),
              trailing: IconButton(
                onPressed: () {
                  Clipboard.setData(
                    const ClipboardData(
                      text: 'TMLjxFWmjb6QuNtYhm3vgCsviGcEHEfuYV',
                    ),
                  );
                  showSnackBar(context, 'TMLjxFWmjb6QuNtYhm3vgCsviGcEHEfuYV copied');
                },
                icon: const Icon(Icons.copy_rounded),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/svgs/usdt.svg',
                height: 30,
                width: 30,
                // ignore: deprecated_member_use
                color: const Color(0xFF50a98f),
              ),
              title: Text(
                'USDT ERC20 (Ethereum)',
                style: roboto(fontWeight: FontWeight.w600),
              ),
              trailing: IconButton(
                onPressed: () {
                  Clipboard.setData(
                    const ClipboardData(
                      text: '0x5DbaDa289a7e161610c68648B78fB5411038D296',
                    ),
                  );
                  showSnackBar(context, '0x5DbaDa289a7e161610c68648B78fB5411038D296 copied');
                },
                icon: const Icon(Icons.copy_rounded),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
