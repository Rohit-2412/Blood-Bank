import 'package:flutter/material.dart';

import '../constants/custom_colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  List<Map<String, String>> chats = [
    {"sender": "u1", "message": "Hello"},
    {"sender": "u2", "message": "Hi"},
    {"sender": "u1", "message": "How are you?"},
    {"sender": "u2", "message": "I am fine, what about you?"},
    {"sender": "u1", "message": "I am also fine"},
    {"sender": "u2", "message": "Ok, bye"},
    {"sender": "u1", "message": "Bye"},
  ];

  void sendMessage() {
    //
  }

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // box to show donor id and call icon
            _header(),

            // messages
            Expanded(child: getMessages()),

            // send message button
            _buildMessageInput(context)
          ]),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CustomColors.firstGradientColor, width: 1.5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: CustomColors.firstGradientColor.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Donor #1",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          Icon(Icons.call, color: Colors.green, size: 28),
        ],
      ),
    );
  }

  Widget getMessages() {
    return ListView(
      children: chats.map((e) => _messageTile(context, e)).toList(),
    );
  }

  Widget _messageTile(BuildContext context, Map<String, String> data) {
    var isMe = data['sender'] == "u1";

    return Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          chatBubble(data['message'], isMe),
          const Text(
            // convert time stamp to hh:mm am/pm format
            "12:00 am",
            style: TextStyle(fontSize: 12),
          ),
        ]);
  }

  Widget chatBubble(message, isMe) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      // textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Flexible(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 0,
                  maxWidth: MediaQuery.of(context).size.width * 0.65,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blueAccent : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontSize: 16),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          Expanded(
              // message input with rounded border
              child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                onSubmitted: (value) => (),
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: "Type a message",
                  border: InputBorder.none,
                ),
              ),
            ),
          )),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
