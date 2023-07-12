import 'package:blood_bank/constants/custom_colors.dart';
import 'package:blood_bank/provider/auth_provider.dart';
import 'package:blood_bank/utils/helper_functions.dart';
import 'package:blood_bank/utils/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          child: _buildRequests(),
        ));
  }

  Widget _buildRequests() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return StreamBuilder(
        // filter requests where status is pending, and it is not in the declined_requests array of user
        stream: FirebaseFirestore.instance
            .collection("requests")
            .where("status", isEqualTo: "pending")
            .where("requested_by", isNotEqualTo: ap.uid)
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

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No requests found!",
                style: MyWidget.textXl.copyWith(fontWeight: FontWeight.w500),
              ),
            );
          }

          // Filter out the documents where declined_by contains user.uid
          // This is done to prevent user from seeing requests that he has declined
          var filteredDocs = snapshot.data!.docs.where((doc) {
            final declinedBy = doc["declined_by"] as List<dynamic>;
            return !declinedBy.contains(ap.uid);
          }).toList();

          if (filteredDocs.isEmpty) {
            return Center(
              child: Text(
                "No requests found!",
                style: MyWidget.textXl.copyWith(fontWeight: FontWeight.w500),
              ),
            );
          }

          return ListView(
            children: filteredDocs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return _buildRequestCard(context, data);
            }).toList(),
          );
        });
  }

// handle accept request
  Future<void> acceptRequest(String id) async {
    // show a thank you popup
    final ap = Provider.of<AuthProvider>(context, listen: false);

    ap.addAcceptedRequest(context, id);
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
  void declineRequest(Map<String, dynamic> data) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
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
                  ap.addDeclinedRequest(context, data['id']);
                  Navigator.of(context).pop();
                },
                child: const Text("Confirm"),
              ),
            ],
          );
        });
  }

  // handle view details
  void viewDetails(Map<String, dynamic> data) {
    // show a popup showing patient age and blood group type along with qty
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Request Details"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Patient Age: ${data['age']} yrs"),
                const SizedBox(height: 10),
                Text("Blood Group: ${data['bloodGroup']}"),
                const SizedBox(height: 10),
                Text("Quantity: ${data['qty']} ml"),
                const SizedBox(height: 10),
                Text(
                    "Requested on: ${HelperFunctions.formatTime(data['createdAt'])}"),
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

  Widget _buildRequestCard(BuildContext context, Map<String, dynamic> data) {
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
              Text("Requester ${data['id'].split("-")[0]}",
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
                      ..onTap = () {
                        viewDetails(data);
                      }),
              )
            ],
          ),

          // accept or decline buttons
          Column(
            children: [
              ElevatedButton(
                onPressed: () => acceptRequest(data['id']),
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
                onPressed: () => declineRequest(data),
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
