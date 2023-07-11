import 'package:blood_bank/constants/custom_colors.dart';
import 'package:blood_bank/provider/auth_provider.dart';
import 'package:blood_bank/screens/auth/phone_number_input.dart';
import 'package:blood_bank/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoarding3 extends StatefulWidget {
  const OnBoarding3({super.key});

  @override
  State<OnBoarding3> createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

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

            // button for get started
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: ElevatedButton(
                onPressed: () async {
                  if (ap.isSignedIn == true) {
                    await ap.getDataFromSP().whenComplete(() =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen())));
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return const PhoneNumberInput();
                      },
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.whiteColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Get Started",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: CustomColors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
