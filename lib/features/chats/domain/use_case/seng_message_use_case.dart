import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/message_entity.dart';
import 'package:ecommerce_admin_app/features/chats/domain/repository/chat_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SengMessageUseCase {
  ChatRepo chatRepo;
  SengMessageUseCase(this.chatRepo);

  Future<Either<Failure, void>> invoke(
    String chatRoomId,
    MessageEntity message,
  ) async {
    return await chatRepo.sendMessage(chatRoomId, message);
  }
}
