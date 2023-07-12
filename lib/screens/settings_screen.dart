import 'package:blood_bank/provider/auth_provider.dart';
import 'package:blood_bank/utils/helper_functions.dart';
import 'package:dice_bear/dice_bear.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    // user avatar
    final avatar = DiceBearBuilder(
      seed: ap.userModel.name,
      sprite: DiceBearSprite.adventurer,
      radius: 50,
    ).build();

    Widget image = avatar.toImage();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        foregroundColor: Colors.white,
        title: const Text(
          "Settings",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black26),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: image,
              ),
              const SizedBox(height: 40),

              // uid
              _buildRow("User ID", "${ap.userModel.uid.substring(0, 10)}..."),
              const SizedBox(height: 20),

              // name
              _buildRow("Name", ap.userModel.name),
              const SizedBox(height: 20),

              // date of birth
              _buildRow("Date of Birth", ap.userModel.dob),
              const SizedBox(height: 20),

              // age
              _buildRow("Age", '${ap.userModel.age.toString()} yrs'),
              const SizedBox(height: 20),

              // blood group
              _buildRow("Blood Group", ap.userModel.bloodGroup),
              const SizedBox(height: 20),

              _buildRow(
                  "Phone Number",
                  HelperFunctions.beautifyPhoneNumber(
                      ap.userModel.phoneNumber)),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
        Text(value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, color: Colors.black87)),
      ],
    );
  }
}
