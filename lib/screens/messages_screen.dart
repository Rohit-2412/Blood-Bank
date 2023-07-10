import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants/custom_colors.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.firstGradientColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Messages",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return messageItem(context, Random().nextInt(9000));
        },
      ),
    );
  }

  Widget messageItem(BuildContext context, int index) {
    // show donor id and mss on left side, on right side show a right icon
    return InkWell(
      onTap: () {
        // navigate to chat screen
        Navigator.pushNamed(context, '/chat');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Donor #$index",
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                // view details
                Text.rich(
                  TextSpan(
                    text: 'Hello, I am available',
                    style: const TextStyle(
                        fontSize: 16,
                        color: CustomColors.grayColor,
                        fontWeight: FontWeight.w500),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // navigate to details screen
                      },
                  ),
                )
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: CustomColors.firstGradientColor,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
