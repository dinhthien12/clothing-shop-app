class Message {
  final String text;
  final bool isMe;
  final DateTime time;

  Message({
    required this.text,
    required this.isMe,
    DateTime? time,
  }) : time = time ?? DateTime.now();
}