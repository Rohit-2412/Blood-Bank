import 'package:blood_bank/provider/auth_provider.dart';
import 'package:blood_bank/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/custom_colors.dart';
import '../utils/helper_functions.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  const ChatScreen({super.key, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  // send message to database
  void sendMessage() async {
    var message = _messageController.text;
    final ap = Provider.of<AuthProvider>(context, listen: false);

    // trim the message to remove any extra spaces
    message = message.trim();

    if (message.isNotEmpty) {
      ap.sendMessage(widget.receiverId, message);
    }
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.firstGradientColor,
        foregroundColor: Colors.white,
        title: Text(
          "Donor ${widget.receiverId.substring(0, 6)}",
          style: const TextStyle(
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
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return StreamBuilder(
        stream: ap.getMessages(widget.receiverId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.redAccent));
          }
          if (snapshot.data!.docs.length == 0) {
            return Center(
                child: Text(
              "No messages yet!",
              style: MyWidget.textXl.copyWith(color: Colors.black),
            ));
          }

          return ListView.builder(
              reverse: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> data = snapshot.data!.docs[index].data();
                return _messageTile(data);
              });
        });
  }

  Widget _messageTile(Map<String, dynamic> data) {
    final userId = Provider.of<AuthProvider>(context, listen: false).uid;
    var isMe = data['senderId'] == userId;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            chatBubble(data['content'], isMe, data['senderId']),
            Text(
              // convert time stamp to hh:mm am/pm format
              HelperFunctions.formatTime(data['createdAt']),
              style: const TextStyle(fontSize: 14),
            ),
          ]),
    );
  }

  Widget chatBubble(message, isMe, String id) {
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
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
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
      padding: const EdgeInsets.only(top: 4),
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
          // send button
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
