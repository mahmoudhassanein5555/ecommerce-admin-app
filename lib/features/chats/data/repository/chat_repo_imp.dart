import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/errors/error_handler.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/chats/data/data_source/chats_data_source.dart';
import 'package:ecommerce_admin_app/features/chats/data/model/message_dto.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/chat_room_entity.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/message_entity.dart';
import 'package:ecommerce_admin_app/features/chats/domain/repository/chat_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ChatRepo)
class ChatRepoImp extends ChatRepo {
  ChatDataSource chatDataSource;
  ChatRepoImp({required this.chatDataSource});
  @override
  Stream<Either<Failure, List<ChatRoomEntity>>> getChatRooms() async* {
    try {
      await for (var chatRoom in chatDataSource.getChatRooms()) {
        final List<ChatRoomEntity> chatRooms = chatRoom.isNotEmpty
            ? chatRoom.map<ChatRoomEntity>((e) => e).toList()
            : [];
        yield right(chatRooms);
      }
    } catch (e) {
      yield left<Failure, List<ChatRoomEntity>>(ErrorHandler.handle(e));
    }
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> getMessages(
    String chatRoomId,
  ) async* {
    try {
      await for (var message in chatDataSource.getMessages(chatRoomId)) {
        final messages = message.isNotEmpty
            ? message.map<MessageEntity>((e) => e).toList()
            : [];
        yield right(messages as List<MessageEntity>);
      }
    } catch (e) {
      yield left<Failure, List<MessageEntity>>(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(
    String chatRoomId,
    MessageEntity message,
  ) async {
    try {
      final response = await chatDataSource.sendMessage(
        chatRoomId,
        MessageDto.fromEntity(message),
      );
      return right(response);
    } catch (e) {
      return left<Failure, void>(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> markChatAsRead(String chatRoomId) async {
    try {
      final response = await chatDataSource.markChatAsRead(chatRoomId);
      return right(response);
    } catch (e) {
      return left<Failure, void>(ErrorHandler.handle(e));
    }
  }
}
