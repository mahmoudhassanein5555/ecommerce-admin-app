import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/chat_room_entity.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/view_model/chats_bloc.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/view_model/chats_event.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/widgets/chat_list_panel.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/widgets/conversation_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatRoomEntity? _selectedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBackground,
      body: Row(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            borderOnForeground: true,
            margin: EdgeInsets.all(8.r),
            shadowColor: AppColors.brown.withValues(alpha: 0.2),
            elevation: 2,
            child: SizedBox(
              width: 310.w,
              child: ChatListPanel(
                selectedUser: _selectedUser,
                onUserSelected: (user) {
                  setState(() {
                    _selectedUser = user;
                  });
                  context.read<ChatsBloc>().add(
                    GetChatMessagesEvent(user.userId),
                  );
                },
              ),
            ),
          ),
          VerticalDivider(width: 1.w, color: AppColors.chatBorder),
          Expanded(child: ConversationPanel(user: _selectedUser)),
        ],
      ),
    );
  }
}
