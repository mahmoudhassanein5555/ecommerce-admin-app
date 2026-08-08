import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomEntity {
  final String userName;
  final String userId;
  final int unreadByAdminCount;
  final String lastSenderId;
  final Timestamp lastMessageTime;
  final String lastMessageText;
  final bool isProductAttachment;
  final String imageUrl;

  ChatRoomEntity({
    required this.userName,
    required this.userId,
    required this.lastMessageText,
    required this.lastMessageTime,
    required this.unreadByAdminCount,
    required this.lastSenderId,
    required this.imageUrl,
    required this.isProductAttachment,
  });
}
