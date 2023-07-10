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
      Navigator.pushReplacementNamed(context, '/onboarding1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // show image in center
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        margin: const EdgeInsets.all(120),
        child: Image.asset(
          'assets/splashScreen/img.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
