import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/chat_room_entity.dart';

class ChatRoomDto extends ChatRoomEntity {
  ChatRoomDto({
    required super.userName,
    required super.userId,
    required super.lastMessageText,
    required super.lastMessageTime,
    required super.unreadByAdminCount,
    required super.lastSenderId,
    required super.imageUrl,
    super.isProductAttachment = false,
  });
  factory ChatRoomDto.fromJson(Map<String, dynamic> json) {
    return ChatRoomDto(
      userName: json['userName']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      lastMessageText: json['lastMessageText']?.toString() ??
          json['lastMessage']?.toString() ??
          '',
      lastMessageTime: json['lastMessageTime'] is Timestamp
          ? json['lastMessageTime'] as Timestamp
          : (json['lastMessageTime'] is DateTime
              ? Timestamp.fromDate(json['lastMessageTime'] as DateTime)
              : Timestamp.now()),
      unreadByAdminCount:
          (json['unreadByAdminCount'] as num?)?.toInt() ?? 0,
      lastSenderId: json['lastSenderId']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      isProductAttachment: json['isProductAttachment'] as bool? ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userId': userId,
      'lastMessageText': lastMessageText,
      'lastMessageTime': lastMessageTime,
      'unreadByAdminCount': unreadByAdminCount,
      'lastSenderId': lastSenderId,
      'imageUrl': imageUrl,
      'isProductAttachment': isProductAttachment,
    };
  }
}
