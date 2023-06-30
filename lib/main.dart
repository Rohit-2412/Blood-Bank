import 'package:blood_bank/screens/FormScreen/otp_input.dart';
import 'package:blood_bank/screens/FormScreen/phone_number_input.dart';
import 'package:blood_bank/screens/FormScreen/sign_up_form.dart';
import 'package:blood_bank/screens/OnboardingScreen/onboarding_1.dart';
import 'package:blood_bank/screens/OnboardingScreen/onboarding_2.dart';
import 'package:blood_bank/screens/OnboardingScreen/onboarding_3.dart';
import 'package:blood_bank/screens/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Bank',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5252)),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding1': (context) => const OnBoarding1(),
        '/onboarding2': (context) => const OnBoarding2(),
        '/onboarding3': (context) => const OnBoarding3(),
        '/phone_number_input': (context) => const PhoneNumberInput(),
        '/otp_input': (context) => const OtpInput(),
        '/sign_up_form': (context) => const SignUpForm(),
      },
    );
  }
}
