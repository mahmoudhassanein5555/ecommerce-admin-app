import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/chat_room_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatListItem extends StatelessWidget {
  final ChatRoomEntity user;
  final bool isSelected;
  final VoidCallback onTap;

  const ChatListItem({
    super.key,
    required this.user,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0.r),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.0.h),
        padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 8.0.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.chatGoldAccent.withValues(alpha: 0.1)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: AppColors.chatAvatarBg,
              child: user.imageUrl.trim().isNotEmpty &&
                      user.imageUrl.startsWith('http')
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(18.r),
                      child: Image.network(
                        user.imageUrl,
                        width: 36.w,
                        height: 36.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Text(
                            user.userName.isNotEmpty
                                ? user.userName[0].toUpperCase()
                                : 'U',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          );
                        },
                      ),
                    )
                  : Text(
                      user.userName.isNotEmpty
                          ? user.userName[0].toUpperCase()
                          : 'U',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.userName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: isSelected
                          ? AppColors.chatGoldAccent
                          : AppColors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    user.lastMessageText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.chatGoldAccent
                          : AppColors.grey600,
                      fontSize: 11.5.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.lastMessageTime.toDate().toString().length > 10
                      ? user.lastMessageTime.toDate().toString().substring(11, 16)
                      : user.lastMessageTime.toDate().toString(),
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.chatGoldAccent
                        : AppColors.grey500,
                    fontSize: 10.5.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                if (user.unreadByAdminCount > 0)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.chatGoldAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      user.unreadByAdminCount.toString(),
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 9.5.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  SizedBox(height: 14.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
