import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/chat_room_entity.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/view_model/chats_bloc.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/view_model/chats_event.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/view_model/chats_state.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/widgets/chat_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatListPanel extends StatefulWidget {
  final ChatRoomEntity? selectedUser;
  final ValueChanged<ChatRoomEntity> onUserSelected;

  const ChatListPanel({
    super.key,
    this.selectedUser,
    required this.onUserSelected,
  });

  @override
  State<ChatListPanel> createState() => _ChatListPanelState();
}

class _ChatListPanelState extends State<ChatListPanel> {
  @override
  void initState() {
    super.initState();
    context.read<ChatsBloc>().add(GetChatRoomsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.0.w, 14.0.h, 16.0.w, 12.0.h),
            child: Text(
              AppStrings.messages,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textDarkSlate,
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.chatBorder),
          Expanded(
            child: BlocBuilder<ChatsBloc, ChatsState>(
              buildWhen: (previous, current) {
                return current is ChatRoomsSuccess ||
                    current is ChatRoomsFailure ||
                    current is ChatRoomsLoading;
              },
              builder: (context, state) {
                if (state is ChatRoomsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.chatGoldAccent,
                    ),
                  );
                } else if (state is ChatRoomsFailure) {
                  return Center(
                    child: Text(
                      state.error,
                      style: TextStyle(
                        color: AppColors.red,
                        fontSize: 13.sp,
                      ),
                    ),
                  );
                } else if (state is ChatRoomsSuccess) {
                  final users = state.chatRooms;
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 4.0.h),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ChatListItem(
                        user: user,
                        isSelected: user == widget.selectedUser,
                        onTap: () => widget.onUserSelected(user),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
