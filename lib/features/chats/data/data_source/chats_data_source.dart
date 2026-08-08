import 'package:ecommerce_admin_app/features/chats/data/model/chat_room_dto.dart';
import 'package:ecommerce_admin_app/features/chats/data/model/message_dto.dart';

abstract class ChatDataSource {
  Stream<List<ChatRoomDto>> getChatRooms();
  Stream<List<MessageDto>> getMessages(String chatRoomId);
  Future<void> sendMessage(String chatRoomId, MessageDto message);
  Future<void> markChatAsRead(String chatRoomId);
}
