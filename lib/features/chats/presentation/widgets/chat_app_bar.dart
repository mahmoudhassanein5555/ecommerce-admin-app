import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/features/chats/domain/entites/chat_room_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ChatRoomEntity user;
  const ChatAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      height: 56.h,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.chatBorder)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.imageUrl),
            radius: 16.r,
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.userName.isNotEmpty
                    ? user.userName
                    : AppStrings.customerDefaultName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.onlineGreen,
                    radius: 3.5.r,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${AppStrings.online}  •  ${AppStrings.customerIdPrefix}${user.userId}',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.search, color: AppColors.grey, size: 18.r),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.grey, size: 18.r),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
