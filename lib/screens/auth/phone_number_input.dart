import 'package:blood_bank/constants/custom_colors.dart';
import 'package:blood_bank/provider/auth_provider.dart';
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

  // set initial text as +91
  _PhoneNumberInputState() {
    _controller.text = "+91";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            // heading
            const Text(
              "Enter your mobile number",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.blackColor),
            ),

            // input box for number
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: TextField(
                autofocus: true,
                autocorrect: false,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: CustomColors.blackColor,
                    fontSize: 24,
                    letterSpacing: 2),
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: CustomColors.blackColor),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // button to get otp having full screen width
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  handleClick(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.buttonBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
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
    if (phoneNumber.length != 13) {
      // show alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return _showAlertDialog();
        },
      );
    } else {
      final ap = Provider.of<AuthProvider>(context, listen: false);
      ap.signInWithPhone(context, phoneNumber);
    }
  }

  Widget _showAlertDialog() {
    return AlertDialog(
      title: const Text(
        'Warning!',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: CustomColors.blackColor),
      ),
      content: const Text(
        'Please enter a valid mobile number!',
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: CustomColors.primaryColorDark),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'OK',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: CustomColors.primaryColorDark),
          ),
        ),
      ],
    );
  }
}
