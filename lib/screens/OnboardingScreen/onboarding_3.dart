import 'package:blood_bank/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class OnBoarding3 extends StatefulWidget {
  const OnBoarding3({super.key});

  @override
  State<OnBoarding3> createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
  @override
  void initState() {
    super.initState();
    // call function after 1.5 second
    Future.delayed(const Duration(milliseconds: 1500), () {
      // navigate to onboarding screen
      Navigator.pushReplacementNamed(context, '/phone_number_input');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
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
              'assets/onboarding/3.png',
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 75),
            const Text(
              textAlign: TextAlign.center,
              "Donate your blood and save a life.",
              style: TextStyle(
                  color: CustomColors.whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
