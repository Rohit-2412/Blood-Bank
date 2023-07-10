import 'package:blood_bank/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class OtpInput extends StatefulWidget {
  const OtpInput({super.key});

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  String otp = "";
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      otp = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    String? number = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
        body: SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            // heading
            const Text(
              "OTP Verification",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),

            // enter the otp sent to your number
            const SizedBox(height: 20),
            Text(
              "Enter the OTP sent to $number",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.grayColor),
            ),

            // Row having 4 boxes for otp using list view
            const SizedBox(height: 40),
            SizedBox(
              height: 50,
              width: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return otpInputBox(context, index);
                },
              ),
            ),

            const SizedBox(height: 20),

            // resend otp
            // "Didn't receive OTP?<black color> Resend OTP <as button> with red color", (in single line)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't receive OTP?",
                  style: TextStyle(fontSize: 20, color: CustomColors.grayColor),
                ),
                const SizedBox(width: 5),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(
                        fontSize: 20, color: CustomColors.primaryColor),
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
                  handleClick();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isValid
                      ? CustomColors.buttonBackground
                      : CustomColors.grayColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Verify",
                  style:
                      TextStyle(fontSize: 24, color: CustomColors.whiteColor),
                ),
              ),
            ),
          ]),
    ));
  }

  void handleClick() {
    // check for otp if all characters are numbers
    if (otp.length == 4 && int.tryParse(otp) != null) {
      Navigator.pushNamed(context, '/sign_up_form');
    }
  }

  Widget otpInputBox(context, index) {
    return Container(
      height: 60,
      width: 50,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      decoration: const BoxDecoration(
        // bottom border only
        border: Border(
          bottom: BorderSide(color: CustomColors.primaryColor, width: 2),
        ),
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        autofocus: true,
        // focus node to move to next box
        onChanged: (value) {
          // if removed the number, focus to previous box
          if (value.isEmpty && index != 0) {
            FocusScope.of(context).previousFocus();
          } else if (value.length == 1 && index != 3) {
            FocusScope.of(context).nextFocus();
          }

          // if user enters the number, store it in otp, if removed the number, remove it from otp
          setState(() {
            if (value.isNotEmpty) {
              otp += value;
            } else {
              otp = otp.substring(0, otp.length - 1);
            }
            isValid = otp.length == 4;
          });
        },
        style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: CustomColors.blackColor),
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
