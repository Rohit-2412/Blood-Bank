import 'package:blood_bank/firebase_options.dart';
import 'package:blood_bank/provider/auth_provider.dart';
import 'package:blood_bank/screens/auth/otp_input.dart';
import 'package:blood_bank/screens/auth/phone_number_input.dart';
import 'package:blood_bank/screens/auth/sign_up_form.dart';
import 'package:blood_bank/screens/chat_screen.dart';
import 'package:blood_bank/screens/history_screen.dart';
import 'package:blood_bank/screens/home_screen.dart';
import 'package:blood_bank/screens/WelcomeScreen/welcome_1.dart';
import 'package:blood_bank/screens/WelcomeScreen/welcome_2.dart';
import 'package:blood_bank/screens/WelcomeScreen/welcome_3.dart';
import 'package:blood_bank/screens/messages_screen.dart';
import 'package:blood_bank/screens/requests_screen.dart';
import 'package:blood_bank/screens/settings_screen.dart';
import 'package:blood_bank/screens/splash_screen.dart';
import 'package:blood_bank/screens/find_donors_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: MaterialApp(
          title: 'Blood Bank',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFFFF5252)),
            useMaterial3: true,
          ),
          initialRoute: '/onboarding3',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/onboarding1': (context) => const OnBoarding1(),
            '/onboarding2': (context) => const OnBoarding2(),
            '/onboarding3': (context) => const OnBoarding3(),
            '/phone_number_input': (context) => const PhoneNumberInput(),
            '/otp_input': (context) => const OtpInput(verificationId: "123"),
            '/sign_up_form': (context) => const SignUpForm(),
            '/home': (context) => const HomeScreen(),
            '/find_donors': (context) => const FindDonors(),
            '/requests': (context) => const RequestsScreen(),
            '/history': (context) => const HistoryScreen(),
            '/messages': (context) => const MessagesScreen(),
            '/chat': (context) => const ChatScreen(),
            '/settings': (context) => const SettingsScreen(),
          },
        ));
  }
}
