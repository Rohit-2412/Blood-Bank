import 'package:blood_bank/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            CustomColors.firstGradientColor,
            CustomColors.secondGradientColor.withAlpha(0xd6)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/onboarding/2.png',
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 75),
            const Text(
              textAlign: TextAlign.center,
              "Your blood type should be compatible with the receiver’s type.",
              style: TextStyle(
                  color: CustomColors.whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
