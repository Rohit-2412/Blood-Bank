import 'package:blood_bank/constants/custom_colors.dart';
import 'package:blood_bank/models/user.dart';
import 'package:blood_bank/provider/auth_provider.dart';
import 'package:blood_bank/screens/home_screen.dart';
import 'package:blood_bank/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

// button for register for checkup
class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  // state variables for input
  String name = "";
  String age = "";
  String healthConditions = "";
  String bloodGroup = "";

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      backgroundColor: CustomColors.firstGradientColor,
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
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

                    const SizedBox(height: 40),

                    TextFormField(
                      autofocus: true,
                      autocorrect: false,
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      style: const TextStyle(
                          color: CustomColors.whiteColor,
                          fontSize: 24,
                          letterSpacing: 2),
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      decoration: MyWidget.outlineDec.copyWith(
                        hintStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.whiteColor),
                        label: const Text(
                          "Full Name",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // input box for date of birth
                    TextFormField(
                      controller: _dateController,
                      onTap: () {
                        _selectDate(context);
                      },
                      style: const TextStyle(
                          color: CustomColors.whiteColor,
                          fontSize: 24,
                          letterSpacing: 2),
                      keyboardType: TextInputType.datetime,
                      maxLines: 1,
                      decoration: MyWidget.outlineDec.copyWith(
                          label: const Text(
                        "Date of Birth",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                    ),

                    const SizedBox(height: 30),

                    // input box for age
                    TextFormField(
                      autofocus: true,
                      autocorrect: false,
                      onChanged: (value) {
                        setState(() {
                          age = value;
                        });
                      },
                      style: const TextStyle(
                          color: CustomColors.whiteColor,
                          fontSize: 24,
                          letterSpacing: 2),
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      decoration: MyWidget.outlineDec.copyWith(
                        label: const Text(
                          "Age",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // input for health condition
                    TextFormField(
                      autofocus: true,
                      autocorrect: false,
                      onChanged: (value) {
                        setState(() {
                          healthConditions = value;
                        });
                      },
                      style: const TextStyle(
                          color: CustomColors.whiteColor,
                          fontSize: 24,
                          letterSpacing: 2),
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      decoration: MyWidget.outlineDec.copyWith(
                        label: const Text(
                          "Prevailing Health Conditions",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // input for blood group
                    TextFormField(
                      autofocus: true,
                      autocorrect: false,
                      onChanged: (value) {
                        setState(() {
                          bloodGroup = value;
                        });
                      },
                      style: const TextStyle(
                          color: CustomColors.whiteColor,
                          fontSize: 24,
                          letterSpacing: 2),
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      decoration: MyWidget.outlineDec.copyWith(
                        label: const Text(
                          "Blood Group",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // button at bottom center
                    ElevatedButton(
                      onPressed: storeData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.whiteColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
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

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
        name: name.trim(),
        dob: _dateController.text,
        age: age.trim(),
        healthConditions: healthConditions.trim(),
        bloodGroup: bloodGroup,
        uid: "",
        phoneNumber: "",
        createdAt: "");
    ap.storeUserData(
      context: context,
      user: userModel,
      onSuccess: () {
        // data is saved store it locally
        ap
            .storeDataToSP()
            .then((value) => ap.setSignIn())
            .then((value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false));
      },
    );
  }
}
