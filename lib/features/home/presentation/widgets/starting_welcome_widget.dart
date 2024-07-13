import 'package:flutter/material.dart';
import 'package:lexisnap/core/theme/app_colors.dart';
import 'package:lexisnap/core/theme/text-styles/poppins.dart';

class StartingWelcomeWidget extends StatelessWidget {
  const StartingWelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Welcome to ',
                  style: poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                TextSpan(
                  text: 'LexiSnap!',
                  style: poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blue,
                  ),
                ),
                TextSpan(
                  text: ' Start your journey to mastering new vocabulary by adding your first word.',
                  style: poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
