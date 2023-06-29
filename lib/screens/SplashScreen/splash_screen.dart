import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
