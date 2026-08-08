import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_app/features/chats/data/data_source/chats_data_source.dart';
import 'package:ecommerce_admin_app/features/chats/data/model/chat_room_dto.dart';
import 'package:ecommerce_admin_app/features/chats/data/model/message_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ChatDataSource)
class ChatDataSourceImp implements ChatDataSource {
  CollectionReference<Map<String, dynamic>> chats = FirebaseFirestore.instance
      .collection('chats');
  @override
  Stream<List<ChatRoomDto>> getChatRooms() {
    return chats
        .orderBy("lastMessageTime", descending: true)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => ChatRoomDto.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Stream<List<MessageDto>> getMessages(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => MessageDto.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Future<void> sendMessage(String chatRoomId, MessageDto message) {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    final messageRef = chats.doc(chatRoomId).collection("messages").doc();
    final roomRef = chats.doc(chatRoomId);
    batch.set(messageRef, message.toJson());
    batch.update(roomRef, {
      "lastMessageText": message.text,
      "lastMessageTime": message.timestamp,
      "lastSenderId": message.senderId,
    });
    return batch.commit();
  }

  @override
  Future<void> markChatAsRead(String chatRoomId) {
    return chats.doc(chatRoomId).update({"unreadByAdminCount": 0});
  }
}
