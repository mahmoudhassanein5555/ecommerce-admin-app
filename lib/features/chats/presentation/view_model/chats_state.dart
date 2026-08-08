import 'package:ecommerce_admin_app/features/chats/domain/entites/chat_room_entity.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/message_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ChatsState with Equatable {
  @override
  List<Object?> get props => [];
}

class ChatsInitial extends ChatsState {}

class GetChatMessagesLoading extends ChatsState {}

class ChatRoomsLoading extends ChatsState {}

class SendMessageLoading extends ChatsState {}

class GetChatsSuccess extends ChatsState {
  final List<MessageEntity> messages;

  GetChatsSuccess(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatRoomsSuccess extends ChatsState {
  final List<ChatRoomEntity> chatRooms;

  ChatRoomsSuccess(this.chatRooms);

  @override
  List<Object?> get props => [chatRooms];
}

class ChatRoomsFailure extends ChatsState {
  final String error;

  ChatRoomsFailure(this.error);
  @override
  List<Object?> get props => [error];
}

class GetChatsFailure extends ChatsState {
  final String error;

  GetChatsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
