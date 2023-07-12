import 'package:blood_bank/constants/custom_colors.dart';
import 'package:blood_bank/provider/auth_provider.dart';
import 'package:blood_bank/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneNumberInput extends StatefulWidget {
  const PhoneNumberInput({super.key});

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  // controller for text field
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/login.jpeg"),
            )),
          ),
          // heading
          const SizedBox(height: 20),

          const Text(
            "Enter your mobile number",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: CustomColors.blackColor),
          ),

          const SizedBox(height: 10),

          // input box for number
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: CustomColors.firstGradientColor, width: 1.5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "+91 ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.blackColor),
                ),
                // input field
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                        letterSpacing: 1,
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: CustomColors.blackColor),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // button to get otp having full screen width
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: ElevatedButton(
              onPressed: () {
                handleClick(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.buttonBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Get OTP",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.whiteColor)),
            ),
          )
        ],
      ),
    );
  }

  // function to dispose controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // function to get number from text field and validate it
  void handleClick(context) async {
    String phoneNumber = _controller.text;
    if (phoneNumber.length != 10) {
      // show snack bar
      MyWidget.showSnackBar(
          context, "Please enter a valid 10-digit mobile number!");
    } else {
      final ap = Provider.of<AuthProvider>(context, listen: false);
      ap.signInWithPhone(context, "+91$phoneNumber");
    }
  }
}
