import 'package:blood_bank/provider/auth_provider.dart';
import 'package:blood_bank/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: _buildChats(),
    );
  }

  Widget _buildChats() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final firestore = FirebaseFirestore.instance;
    // for each chat room check if the participants array contains the current user
    return StreamBuilder(
      stream: firestore.collection('chat_rooms').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final chatRooms = snapshot.data!.docs;
          return ListView.builder(
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              final chatRoom = chatRooms[index];
              final participants = chatRoom['participants'] as List;
              String otherUserId =
                  participants[0] == ap.uid ? participants[1] : participants[0];

              if (participants.contains(ap.uid)) {
                return messageItem(context, otherUserId);
              } else {
                return const SizedBox();
              }
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget messageItem(BuildContext context, String otherUserId) {
    // show donor id and mss on left side, on right side show a right icon
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ChatScreen(receiverId: otherUserId);
          },
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                Text("Donor #${otherUserId.substring(0, 5)}",
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
