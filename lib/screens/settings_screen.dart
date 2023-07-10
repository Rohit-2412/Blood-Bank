import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
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

              // name
              const SizedBox(height: 40),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                  Text("John Doe",
                      style: TextStyle(fontSize: 24, color: Colors.black87)),
                ],
              ),
              const SizedBox(height: 20),

              // date of birth
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Date of Birth",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                  Text("01/01/2000",
                      style: TextStyle(fontSize: 24, color: Colors.black87)),
                ],
              ),
              const SizedBox(height: 20),

              // age
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Age",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                  Text("21",
                      style: TextStyle(fontSize: 24, color: Colors.black87)),
                ],
              ),
              const SizedBox(height: 20),

              // blood group
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Blood Group",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                  Text("A+",
                      style: TextStyle(fontSize: 24, color: Colors.black87)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
