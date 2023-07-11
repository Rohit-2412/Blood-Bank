import 'package:blood_bank/constants/custom_colors.dart';
import 'package:blood_bank/models/patient_request.dart';
import 'package:blood_bank/provider/auth_provider.dart';
import 'package:blood_bank/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindDonors extends StatefulWidget {
  const FindDonors({super.key});

  @override
  State<FindDonors> createState() => _FindDonorsState();
}

class _FindDonorsState extends State<FindDonors> {
  String gender = "";
  String bloodType = "";
  String relation = "";
  String age = "";
  String quantity = "";

  List<String> genders = ["Male", "Female"];

  List<String> bloodGroups = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];

  List<String> relations = [
    "Family",
    "Friend",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: CustomColors.firstGradientColor,
          foregroundColor: Colors.white,
          title: const Text("Find Donors",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              )),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.redAccent,
                ),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text("Patient Blood Type",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(height: 10),

                    // display 8 buttons for blood types to choose from
                    _buildBloodGroupButtons(size),

                    const SizedBox(height: 30),

                    const Text(
                      "Patient Gender",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // display 2 buttons male / female to choose from
                    _buildGenderRow(),

                    const SizedBox(height: 30),

                    const Text(
                      "Patient Relation",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // display 3 buttons for relations to choose from
                    _buildRelationRow(),

                    const SizedBox(height: 30),

                    _buildPatientAgeComponent(),

                    const SizedBox(height: 30),

                    // quantity box
                    _buildQuantityBox(),

                    const Spacer(),

                    // send requests button
                    _buildSendRequestButton(context, size),

                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ));
  }

  Center _buildBloodGroupButtons(Size size) {
    return Center(
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        children:
            bloodGroups.map((e) => _buildBloodTypeButton(e, e, size)).toList(),
      ),
    );
  }

  Widget _buildGenderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: genders.map((e) => getGenderButton(e, e)).toList(),
    );
  }

  Widget getGenderButton(String label, String choice) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          gender = choice;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            gender == choice ? CustomColors.firstGradientColor : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: gender == choice ? Colors.white : Colors.red),
      ),
    );
  }

  Row _buildRelationRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: relations.map((e) => getRelationButton(e, e)).toList(),
    );
  }

  SizedBox _buildPatientAgeComponent() {
    return SizedBox(
      height: 40,
      width: 250,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Patient Age",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 100,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  age = value;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: CustomColors.firstGradientColor, width: 2),
                ),
                hintText: "Age",
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleSubmit() {
    // if any of the field is empty show error message in snackbar
    if (bloodType == "" || relation == "" || age == "" || quantity == "") {
      MyWidget.showSnackBar(context, "Please fill all the fields");
    } else {
      final ap = Provider.of<AuthProvider>(context, listen: false);

      PatientRequest request = PatientRequest(
        age: age,
        gender: gender,
        bloodType: bloodType,
        relation: relation,
        phoneNumber: '',
        createdAt: '',
        id: '',
        qty: quantity,
      );

      ap.saveRequest(context, request).then(
            (value) =>
                MyWidget.showSnackBar(context, "Request Sent Successfully"),
          );
    }
  }

  Container _buildSendRequestButton(BuildContext context, Size size) {
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ElevatedButton(
          // show a snack bar showing successfully sent request
          onPressed: handleSubmit,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Send Requests",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
          )),
    );
  }

  Widget _buildBloodTypeButton(String label, String choice, Size size) {
    // use inkwell and container to make a button which has red bg is selected with a shadow in all
    return InkWell(
      onTap: () {
        setState(() {
          bloodType = choice;
        });
      },
      child: Container(
        width: size.width * 0.2,
        height: size.height * 0.05,
        decoration: BoxDecoration(
          color: bloodType == choice ? Colors.redAccent : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: bloodType == choice
                  ? Colors.red.withOpacity(0.5)
                  : Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: bloodType == choice ? Colors.white : Colors.redAccent),
          ),
        ),
      ),
    );
  }

  Widget getRelationButton(String label, String choice) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          relation = choice;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: relation == choice ? Colors.red : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: relation == choice ? Colors.white : Colors.red),
      ),
    );
  }

  Widget _buildQuantityBox() {
    return SizedBox(
      height: 40,
      width: 250,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Quantity (in ml)",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 100,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  quantity = value;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: CustomColors.firstGradientColor, width: 2),
                ),
                hintText: "Quantity",
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
