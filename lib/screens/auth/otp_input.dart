import 'package:blood_bank/constants/custom_colors.dart';
import 'package:blood_bank/screens/auth/sign_up_form.dart';
import 'package:blood_bank/screens/home_screen.dart';
import 'package:blood_bank/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../utils/helper_functions.dart';

class OtpInput extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const OtpInput(
      {super.key, required this.verificationId, required this.phoneNumber});

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;

    return Scaffold(
        backgroundColor: CustomColors.whiteColor,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.redAccent,
              ))
            : Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/otp.jpg"),
                          ),
                        ),
                      ),

                      // heading
                      const Text(
                        "OTP Verification",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),

                      // enter the otp sent to your number
                      const SizedBox(height: 20),
                      Text(
                        "Enter the OTP sent to ${HelperFunctions.beautifyPhoneNumber(widget.phoneNumber)}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.grayColor),
                      ),
                      const SizedBox(height: 20),
                      // Row having 4 boxes for otp using list view
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: CustomColors.firstGradientColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onChanged: (String pin) {
                            setState(() {
                              otp = pin;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // resend otp
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Didn't receive an OTP?",
                            style: TextStyle(
                                fontSize: 20, color: CustomColors.blackColor),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Resend OTP",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: CustomColors.primaryColor),
                            ),
                          ),
                        ],
                      ),
                      // verify button
                      const SizedBox(height: 40),

                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            if (otp.length == 6) {
                              verifyOtp(context, otp);
                            } else {
                              MyWidget.showSnackBar(
                                  context, "Please enter a valid OTP");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.buttonBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Verify",
                            style: TextStyle(
                                fontSize: 24, color: CustomColors.whiteColor),
                          ),
                        ),
                      ),
                    ]),
              ));
  }

  void verifyOtp(BuildContext context, String otp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        otp: otp,
        onSuccess: () {
          // whether user exist in db
          ap.checkExistingUser().then((value) async {
            if (value == true) {
              // user exists
              ap
                  .getDataFromFirestore()
                  .then((value) => ap.storeDataToSP())
                  .then((value) => ap.setSignIn())
                  .then((value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const HomeScreen()),
                      ),
                      (route) => false));
            } else {
              // no user exists
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpForm()),
                  (route) => false);
            }
          });
        });
  }
}
