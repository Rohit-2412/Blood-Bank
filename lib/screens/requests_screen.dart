import 'dart:math';

import 'package:blood_bank/constants/custom_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.firstGradientColor,
          foregroundColor: Colors.white,
          title: const Text("Requests",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500)),
        ),
        body: Container(
          color: Colors.grey[200],
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return _buildRequestCard(context, Random().nextInt(9000));
            },
          ),
        ));
  }

// handle accept request
  void acceptRequest() {
    // show a thank you popup
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Thank you!"),
            content: const Text(
                "Your gift of blood is a lifeline that saves lives and brings hope."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          );
        });
  }

// handle decline request
  void declineRequest() {
    // show a popup stating Are you sure? and 2 buttons to confirm or cancel
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Are you sure?"),
            content: const Text(
                "Your choice not to donate is respected, but remember the incredible impact you could have in saving lives through a simple act of giving."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Confirm"),
              ),
            ],
          );
        });
  }

  // handle view details
  void viewDetails() {
    // show a popup showing patient age and blood group type along with qty
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Request Details"),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Patient Age: 20"),
                SizedBox(height: 10),
                Text("Blood Group: A+"),
                SizedBox(height: 10),
                Text("Quantity: 200 ml"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          );
        });
  }

  Widget _buildRequestCard(BuildContext context, int id) {
    // return a container with req id at left and 2 vertical buttons to accept or decline
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // requester id and view details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Requester #$id",
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              // view details
              Text.rich(
                TextSpan(
                    text: 'View Details',
                    style: const TextStyle(
                        fontSize: 16,
                        color: CustomColors.firstGradientColor,
                        fontWeight: FontWeight.w500),
                    recognizer: TapGestureRecognizer()
                      // show details of request
                      ..onTap = viewDetails),
              )
            ],
          ),

          // accept or decline buttons
          Column(
            children: [
              ElevatedButton(
                onPressed: acceptRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.firstGradientColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Accept",
                  style:
                      TextStyle(color: CustomColors.whiteColor, fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: declineRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Decline",
                  style:
                      TextStyle(color: CustomColors.blackColor, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
