import 'package:ecommerce_admin_app/features/chats/domain/entites/message_entity.dart';
import 'package:ecommerce_admin_app/features/chats/domain/use_case/get_chat_messages_use_case.dart';
import 'package:ecommerce_admin_app/features/chats/domain/use_case/get_chat_rooms_use_case.dart';
import 'package:ecommerce_admin_app/features/chats/domain/use_case/seng_message_use_case.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/view_model/chats_event.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/view_model/chats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  GetChatRoomsUseCase getChatRoomsUseCase;
  GetChatMessagesUseCase getChatMessagesUseCase;
  SengMessageUseCase sengMessageUseCase;
  List<MessageEntity> _messages = [];
  ChatsBloc(
    this.getChatRoomsUseCase,
    this.getChatMessagesUseCase,
    this.sengMessageUseCase,
  ) : super(ChatsInitial()) {
    on<GetChatRoomsEvent>((event, emit) async {
      emit(ChatRoomsLoading());
      await emit.forEach(
        getChatRoomsUseCase.invoke(),
        onData: (either) {
          return either.fold(
            (faliure) {
              return ChatRoomsFailure(faliure.failuremessage);
            },
            (chatRooms) {
              return ChatRoomsSuccess(chatRooms);
            },
          );
        },
        onError: (error, stackTrace) {
          return ChatRoomsFailure(error.toString());
        },
      );
    });
    on<GetChatMessagesEvent>((event, emit) async {
      _messages.clear();
      emit(GetChatMessagesLoading());
      await emit.forEach(
        getChatMessagesUseCase.invoke(event.chatRoomId),
        onData: (either) {
          return either.fold(
            (faliure) {
              return GetChatsFailure(faliure.failuremessage);
            },
            (remoteMessages) {
              _messages = remoteMessages;
              return GetChatsSuccess(_messages);
            },
          );
        },
        onError: (error, stackTrace) {
          return GetChatsFailure(error.toString());
        },
      );
    });
    on<SendMessageEvent>((event, emit) async {
      emit(SendMessageLoading());
      _messages.add(event.message);
      var response = await sengMessageUseCase.invoke(
        event.chatRoomId,
        event.message,
      );
      response.fold(
        (faliure) {
          _messages.remove(event.message);
          emit(GetChatsFailure(faliure.failuremessage));
        },
        (success) {},
      );
    });
  }
}
