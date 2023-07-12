import 'package:blood_bank/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // init state
  @override
  void initState() {
    super.initState();
    // call function after 3 second
    Future.delayed(const Duration(seconds: 3), () {
      // navigate to onboarding screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return const WelcomeScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/splash_screen.png',
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'Uniting Donors and Recipients\nBlood Bank App for All',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w500, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
