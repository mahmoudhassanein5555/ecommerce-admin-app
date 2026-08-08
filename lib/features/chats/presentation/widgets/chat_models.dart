class ChatUser {
  final String imageUrl;
  final String name;
  final String messagePreview;
  final String time;
  final int unreadCount;
  final bool isActive;

  ChatUser({
    required this.imageUrl,
    required this.name,
    required this.messagePreview,
    required this.time,
    this.unreadCount = 0,
    this.isActive = false,
  });
}

class ChatMessage {
  final String text;
  final String time;
  final bool isSender;
  final bool isProductAttachment;

  ChatMessage({
    required this.text,
    required this.time,
    required this.isSender,
    this.isProductAttachment = false,
  });
}
