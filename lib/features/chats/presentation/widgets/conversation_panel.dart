import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/core/di/servicelocator.dart';
import 'package:ecommerce_admin_app/core/utils/shared_prefs_local_data_source.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/chat_room_entity.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/view_model/chats_bloc.dart';
import 'package:ecommerce_admin_app/features/chats/presentation/view_model/chats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'chat_app_bar.dart';
import 'chat_input_field.dart';
import 'message_bubble.dart';

class ConversationPanel extends StatefulWidget {
  final ChatRoomEntity? user;

  const ConversationPanel({super.key, this.user});

  @override
  State<ConversationPanel> createState() => _ConversationPanelState();
}

class _ConversationPanelState extends State<ConversationPanel> {
  @override
  Widget build(BuildContext context) {
    final String adminId =
        getIt<CacheHelper>().getData(key: "id")?.toString() ??
        AppStrings.defaultAdminId;

    if (widget.user == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300.w,
              height:300.h,
              child: Lottie.asset('assets/animations/call_center.json'),
            ),
            SizedBox(height: 12.h),
            Text(
              AppStrings.selectChatToStartMessaging,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.grey600,
              ),
            ),
          ],
        ),
      );
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      borderOnForeground: true,
      margin: EdgeInsets.all(8.r),
      shadowColor: AppColors.brown.withValues(alpha: 0.2),
      elevation: 2,
      child: Column(
        children: [
          ChatAppBar(user: widget.user!),
          Expanded(
            child: BlocBuilder<ChatsBloc, ChatsState>(
              buildWhen: (previous, current) {
                return current is GetChatsSuccess ||
                    current is GetChatsFailure ||
                    current is GetChatMessagesLoading;
              },
              builder: (context, state) {
                if (state is GetChatMessagesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.chatGoldAccent,
                    ),
                  );
                } else if (state is GetChatsFailure) {
                  return Center(
                    child: Text(
                      state.error,
                      style: TextStyle(
                        color: AppColors.red,
                        fontSize: 13.sp,
                      ),
                    ),
                  );
                } else if (state is GetChatsSuccess) {
                  final messages = state.messages;
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w,
                      vertical: 12.0.h,
                    ),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return MessageBubble(
                        message: message,
                        isSender: adminId == message.senderId,
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          ChatInputField(chatRoomId: widget.user!.userId),
        ],
      ),
    );
  }
}
