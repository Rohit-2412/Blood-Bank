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
    var message = _messageController.text;
    // trim the message to remove any extra spaces
    message = message.trim();
    if (message.isNotEmpty) {
      setState(() {
        chats.add({"sender": "u1", "message": message});
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.firstGradientColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Donor #1",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // messages
            Expanded(child: getMessages()),

            // send message button
            _buildMessageInput(context)
          ]),
        ),
      ),
    );
  }

  Widget getMessages() {
    // using stream builder to listen to changes in the chats list
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (BuildContext context, int index) {
            return _messageTile(chats[index]);
          },
        );
      },
    );
  }

  Widget _messageTile(Map<String, String> data) {
    var isMe = data['sender'] == "u1";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            chatBubble(data['message'], isMe),
            const Text(
              // convert time stamp to hh:mm am/pm format
              "12:00 am",
              style: TextStyle(fontSize: 12),
            ),
          ]),
    );
  }

  Widget chatBubble(message, isMe) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
                    color: isMe ? Colors.redAccent : Colors.grey[350],
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
    return Row(
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
    );
  }
}
