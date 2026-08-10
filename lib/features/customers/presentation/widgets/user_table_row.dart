import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/user_avatar_widget.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/user_profile_dialog.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/user_role_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserTableRow extends StatelessWidget {
  final UserEntity user;

  const UserTableRow({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        UserProfileDialog.show(
          context,
          userId: user.id,
          initialUser: user,
        );
      },
      hoverColor: AppColors.surfaceSoft.withValues(alpha: 0.5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Row(
          children: [
            // User Avatar & Name
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  UserAvatarWidget(
                    imageUrl: user.avatar,
                    fallbackName: user.name,
                    size: 40,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name.isNotEmpty ? user.name : 'Unknown',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'ID: #${user.id}',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // User ID column
            Expanded(
              flex: 2,
              child: Text(
                '#${user.id}',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            // Email column
            Expanded(
              flex: 4,
              child: Text(
                user.email,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Role column
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: UserRoleBadge(role: user.role),
              ),
            ),

            // Actions column
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    UserProfileDialog.show(
                      context,
                      userId: user.id,
                      initialUser: user,
                    );
                  },
                  icon: Icon(Icons.visibility_outlined, size: 14.r, color: AppColors.textBrown),
                  label: Text(
                    AppStrings.viewProfile,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.textBrown,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFBF8EE),
                    foregroundColor: AppColors.textBrown,
                    elevation: 0,
                    side: const BorderSide(color: AppColors.goldAccent, width: 0.8),
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
