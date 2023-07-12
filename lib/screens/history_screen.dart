import 'package:blood_bank/screens/chat_screen.dart';
import 'package:blood_bank/utils/helper_functions.dart';
import 'package:blood_bank/constants/custom_colors.dart';
import 'package:blood_bank/provider/auth_provider.dart';
import 'package:blood_bank/utils/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    _buildButton('Donated', 'donate'),
                    const SizedBox(width: 16),
                    _buildButton('Received', 'receive'),
                  ],
                ),
              ),

              // list
              Expanded(
                child: tab == 'donate'
                    ? _buildDonatedList()
                    : _buildReceivedList(),
              ),
            ],
          )),
    );
  }

  Widget _buildReceivedList() {
    // for each collection in requests, fetch the requests and show them in a list where donor id is current user id
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return StreamBuilder(
        stream: firestore
            .collection("requests")
            .where("requested_by", isEqualTo: ap.uid)
            .where("status", isEqualTo: "accepted")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> item =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return getReceiveItem(context, item);
            },
          );
        });
  }

  Widget _buildDonatedList() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return StreamBuilder(
      stream: firestore
          .collection("requests")
          .where("donor", isEqualTo: ap.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.redAccent,
            ),
          );
        }

        if (snapshot.data!.docs.length == 0) {
          return Center(
              child: Text(
            "No donated history found!",
            style: MyWidget.textXl.copyWith(fontWeight: FontWeight.w500),
          ));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            // get the request details
            Map<String, dynamic> request =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            return getDonateItem(context, request);
          },
        );
      },
    );
  }

  Widget _buildButton(String text, String tabName) {
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

  Widget getDonateItem(BuildContext context, Map<String, dynamic> request) {
    // return a container having date and location at the left side of card, receiver id and qty at the right side of card
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            receiverId: request['requested_by'],
          ),
        ),
      ),
      child: Container(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date : ${HelperFunctions.formatDate(request['createdAt'])}',
                  style: const TextStyle(
                    color: CustomColors.blackColor,
                    fontSize: 20,
                  ),
                ),
                const Text(
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
                  'Receiver ID ${request['requested_by'].substring(0, 4)}',
                  style: const TextStyle(
                    color: CustomColors.blackColor,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Qty: ${request['qty']}ml',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getReceiveItem(BuildContext context, Map<String, dynamic> data) {
    // return a container having date and location at the left side of card, receiver id and qty and view details at the right side of card
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            receiverId: data['donor'],
          ),
        ),
      ),
      child: Container(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date: ${HelperFunctions.formatDate(data['createdAt'])}',
                  style: const TextStyle(
                    color: CustomColors.blackColor,
                    fontSize: 20,
                  ),
                ),
                const Text(
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
                  'Donor ID ${data['donor'].substring(0, 4)}',
                  style: const TextStyle(
                    color: CustomColors.blackColor,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Qty: 0.${data['qty']}ml',
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
                        // show a bottom containing donor details
                        showModalBottomSheet(
                          useSafeArea: true,
                          context: context,
                          enableDrag: true,
                          builder: (_) => showDonorDetails(data['donor']),
                        );
                      },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget showDonorDetails(String donorId) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return StreamBuilder(
        stream: firestore.collection("users").doc(donorId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> s) {
          if (s.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }

          if (s.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            );
          }
          // get the user details
          Map<String, dynamic> user = s.data!.data() as Map<String, dynamic>;
          return Container(
            width: MediaQuery.of(context).size.width - 12,
            height: 180,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _bottomSheetText('Name: ${user['name']}'),
                _bottomSheetText('Phone Number: ${user['phoneNumber']}'),
                _bottomSheetText('Age: ${user['age']}'),
                _bottomSheetText('Blood Group: ${user['bloodGroup']}'),
              ],
            ),
          );
        });
  }

  Text _bottomSheetText(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
