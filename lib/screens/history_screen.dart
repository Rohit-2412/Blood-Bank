import 'package:blood_bank/constants/custom_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String tab = "donate";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.firstGradientColor,
        foregroundColor: Colors.white,
        title: const Text('History',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Container(
                height: 50,
                // two buttons to switch between donate and receive
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    getButton('Donated', 'donate'),
                    const SizedBox(width: 16),
                    getButton('Received', 'receive'),
                  ],
                ),
              ),

              // list
              Expanded(
                child: tab == 'donate'
                    ? ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return getDonateItem(context, index);
                        },
                      )
                    : ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return getReceiveItem(context, index);
                        },
                      ),
              ),
            ],
          )),
    );
  }

  Widget getButton(String text, String tabName) {
    // return a button with text and color according to the tabName
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            tab = tabName;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: tab == tabName
                ? CustomColors.firstGradientColor
                : CustomColors.whiteColor,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: tab == tabName
                    ? CustomColors.whiteColor
                    : CustomColors.blackColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getDonateItem(BuildContext context, int index) {
    // return a container having date and location at the left side of card, receiver id and qty at the right side of card
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date: 01/12/12',
                style: TextStyle(
                  color: CustomColors.blackColor,
                  fontSize: 20,
                ),
              ),
              Text(
                'Location : 123, XYZ Apt',
                style: TextStyle(
                  color: CustomColors.grayColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Receiver ID #$index',
                style: const TextStyle(
                  color: CustomColors.blackColor,
                  fontSize: 20,
                ),
              ),
              Text(
                'Qty: 0.${index + 1} ounces',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getReceiveItem(BuildContext context, int index) {
    // return a container having date and location at the left side of card, receiver id and qty and view details at the right side of card
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date: 01/12/12',
                style: TextStyle(
                  color: CustomColors.blackColor,
                  fontSize: 20,
                ),
              ),
              Text(
                'Location : 123, XYZ Apt',
                style: TextStyle(
                  color: CustomColors.grayColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Donor ID #$index',
                style: const TextStyle(
                  color: CustomColors.blackColor,
                  fontSize: 20,
                ),
              ),
              Text(
                'Qty: 0.${index + 1} ounces',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  text: 'View Details',
                  style: const TextStyle(
                    color: CustomColors.firstGradientColor,
                    fontSize: 16,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // navigate to details screen
                    },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
