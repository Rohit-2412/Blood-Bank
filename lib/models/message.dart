class MessageModel {
  String content;
  String createAt;
  String receiverId;
  String senderId;
  String senderName;

  MessageModel({
    required this.content,
    required this.createAt,
    required this.receiverId,
    required this.senderId,
    required this.senderName,
  });

  // convert to map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'content': content,
      'createdAt': createAt
    };
  }
}
