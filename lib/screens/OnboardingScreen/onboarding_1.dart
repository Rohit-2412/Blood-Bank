import 'package:blood_bank/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({super.key});

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  @override
  void initState() {
    super.initState();
    // call function after 1.5 second
    Future.delayed(const Duration(milliseconds: 1500), () {
      // navigate to onboarding screen
      Navigator.pushReplacementNamed(context, '/onboarding2');
    });
  }

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
              'assets/onboarding/1.png',
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 75),
            const Text(
              textAlign: TextAlign.center,
              "To be a responsible donor, you must get a check-up.",
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
