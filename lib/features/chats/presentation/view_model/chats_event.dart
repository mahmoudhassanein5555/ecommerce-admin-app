import 'package:ecommerce_admin_app/features/chats/domain/entites/message_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ChatsEvent with Equatable {
  @override
  List<Object?> get props => [];
}

class GetChatMessagesEvent extends ChatsEvent {
  final String chatRoomId;

  GetChatMessagesEvent(this.chatRoomId);

  @override
  List<Object?> get props => [chatRoomId];
}

class GetChatRoomsEvent extends ChatsEvent {}

class SendMessageEvent extends ChatsEvent {
  final MessageEntity message;
  final String chatRoomId;

  SendMessageEvent(this.message, {required this.chatRoomId});

  @override
  List<Object?> get props => [message];
}

class GetChatRoomByIdEvent extends ChatsEvent {
  final String chatroomId;

  GetChatRoomByIdEvent(this.chatroomId);

  @override
  List<Object?> get props => [chatroomId];
}
