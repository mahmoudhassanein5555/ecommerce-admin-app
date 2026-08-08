import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/chat_room_entity.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/message_entity.dart';

abstract class ChatRepo {
  Stream<Either<Failure, List<ChatRoomEntity>>> getChatRooms();
  Stream<Either<Failure, List<MessageEntity>>> getMessages(String chatRoomId);
  Future<Either<Failure, void>> sendMessage(
    String chatRoomId,
    MessageEntity message,
  );
  Future<Either<Failure, void>> markChatAsRead(String chatRoomId);
}
