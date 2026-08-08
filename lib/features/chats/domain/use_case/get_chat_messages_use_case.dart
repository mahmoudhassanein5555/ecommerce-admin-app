import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/message_entity.dart';
import 'package:ecommerce_admin_app/features/chats/domain/repository/chat_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetChatMessagesUseCase {
  ChatRepo chatRepo;
  GetChatMessagesUseCase(this.chatRepo);

  Stream<Either<Failure, List<MessageEntity>>> invoke(String chatRoomId) =>
      chatRepo.getMessages(chatRoomId);
}
