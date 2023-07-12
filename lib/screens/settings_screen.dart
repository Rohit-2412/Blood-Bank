import 'package:blood_bank/provider/auth_provider.dart';
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
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(50)),
                child: const Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),

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
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
        Text(value,
            style: const TextStyle(fontSize: 20, color: Colors.black87)),
      ],
    );
  }
}
