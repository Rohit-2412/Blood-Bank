import 'package:blood_bank/constants/custom_colors.dart';
import 'package:blood_bank/provider/auth_provider.dart';
import 'package:blood_bank/screens/auth/phone_number_input.dart';
import 'package:blood_bank/screens/home_screen.dart';
import 'package:blood_bank/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final controller = PageController();

    List<Widget> pages = [
      // page1(),
      // page2(),
      page3(ap),
    ];

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 125,
                child: PageView(
                  controller: controller,
                  children: pages,
                ),
              ),

              // indicator
              SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                // effect: WormEffect(),
                effect: const WormEffect(
                  dotColor: CustomColors.whiteColor,
                  activeDotColor: Colors.redAccent,
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 15,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future handleGetStarted(AuthProvider ap) async {
    if (ap.isSignedIn == true) {
      await ap.getDataFromSP().whenComplete(() => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen())));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const PhoneNumberInput();
        },
      ));
    }
  }

  Widget page3(AuthProvider ap) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 100),
          child: Image.asset(
            'assets/onboarding/3.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 50),
        Text(
          textAlign: TextAlign.center,
          "Donate your blood and save a life.",
          style: MyWidget.heading,
        ),

        // button for get started
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
          child: ElevatedButton(
            onPressed: () => handleGetStarted(ap),
            style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
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
    );
  }

  Widget page2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/onboarding/2.png',
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 75),
        Text(
          textAlign: TextAlign.center,
          "Your blood type should be compatible with the receiver's type.",
          style: MyWidget.heading,
        )
      ],
    );
  }

  Widget page1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/onboarding/1.png',
        ),
        const SizedBox(height: 75),
        Text(
          textAlign: TextAlign.center,
          "To be a responsible donor, you must get a check-up.",
          style: MyWidget.heading,
        )
      ],
    );
  }
}
