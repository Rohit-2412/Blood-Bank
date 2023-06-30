import 'package:blood_bank/constants/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

// button for register for checkup
class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  // state variables for input
  String fullName = "";
  String dob = "";
  String age = "";
  String healthConditions = "";
  String bloodGroup = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firstGradientColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
        height: double.maxFinite,
        child: Column(
          children: [
            const SizedBox(height: 50),
            // heading
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.whiteColor),
                )),

            const SizedBox(height: 20),
            // label for full name
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Full Name",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.whiteColor),
              ),
            ),
            // input box for full name
            TextField(
              autofocus: true,
              autocorrect: false,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    fullName += value;
                  });
                } else {
                  setState(() {
                    fullName = fullName.substring(0, fullName.length - 1);
                  });
                }
              },
              style: const TextStyle(
                  color: CustomColors.whiteColor,
                  fontSize: 24,
                  letterSpacing: 2),
              keyboardType: TextInputType.name,
              cursorOpacityAnimates: true,
              maxLines: 1,
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.whiteColor),
              ),
            ),

            const SizedBox(height: 20),
            // label for date of birth
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Date of Birth",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.whiteColor),
              ),
            ),

            // input box for date of birth
            TextField(
              controller: _dateController,
              onTap: () {
                _selectDate(context);
              },
              style: const TextStyle(
                  color: CustomColors.whiteColor,
                  fontSize: 24,
                  letterSpacing: 2),
              keyboardType: TextInputType.datetime,
              cursorOpacityAnimates: true,
              maxLines: 1,
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.whiteColor),
              ),
            ),

            const SizedBox(height: 20),
            // label for age
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Age",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.whiteColor),
              ),
            ),

            // input box for age
            TextField(
              autofocus: true,
              autocorrect: false,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    age += value;
                  });
                } else {
                  setState(() {
                    age = age.substring(0, age.length - 1);
                  });
                }
              },
              style: const TextStyle(
                  color: CustomColors.whiteColor,
                  fontSize: 24,
                  letterSpacing: 2),
              keyboardType: TextInputType.number,
              cursorOpacityAnimates: true,
              maxLines: 1,
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.whiteColor),
              ),
            ),

            const SizedBox(height: 20),
            // label for health conditions
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Health Conditions",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.whiteColor),
              ),
            ),

            // input for health condition
            TextField(
              autofocus: true,
              autocorrect: false,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    healthConditions += value;
                  });
                } else {
                  setState(() {
                    healthConditions = healthConditions.substring(
                        0, healthConditions.length - 1);
                  });
                }
              },
              style: const TextStyle(
                  color: CustomColors.whiteColor,
                  fontSize: 24,
                  letterSpacing: 2),
              keyboardType: TextInputType.number,
              cursorOpacityAnimates: true,
              maxLines: 1,
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.whiteColor),
              ),
            ),

            const SizedBox(height: 20),
            // label for blood group
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Blood Group",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.whiteColor),
              ),
            ),

            // input for blood group
            TextField(
              autofocus: true,
              autocorrect: false,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    healthConditions += value;
                  });
                } else {
                  setState(() {
                    healthConditions = healthConditions.substring(
                        0, healthConditions.length - 1);
                  });
                }
              },
              style: const TextStyle(
                  color: CustomColors.whiteColor,
                  fontSize: 24,
                  letterSpacing: 2),
              keyboardType: TextInputType.number,
              cursorOpacityAnimates: true,
              maxLines: 1,
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.whiteColor),
              ),
            ),

            const Spacer(),

            // button at bottom center
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.whiteColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "REGISTER FOR CHECKUP",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                    color: CustomColors.primaryColor),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
