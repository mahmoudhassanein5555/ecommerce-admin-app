import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/user_avatar_widget.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/user_profile_info_row.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/user_role_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileContent extends StatelessWidget {
  final UserEntity user;
  final bool isLoading;

  const UserProfileContent({
    super.key,
    required this.user,
    this.isLoading = false,
  });

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header with close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.userProfileTitle,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontFamily: 'SwiftBuyHeading',
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close, size: 22.r, color: AppColors.grey600),
                splashRadius: 20.r,
              ),
            ],
          ),
          const Divider(color: AppColors.borderLight),
          SizedBox(height: 16.h),

          // Large Avatar
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              UserAvatarWidget(
                imageUrl: user.avatar,
                fallbackName: user.name,
                size: 110,
                border: Border.all(color: AppColors.goldAccent, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.goldAccent.withValues(alpha: 0.18),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              if (isLoading)
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.goldAccent,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 14.h),

          // Full Name
          Text(
            user.name.isNotEmpty ? user.name : 'Unknown User',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontFamily: 'SwiftBuyHeading',
            ),
          ),
          SizedBox(height: 8.h),

          // Role Badge
          UserRoleBadge(
            role: user.role,
            fontSize: 13.sp,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
          ),
          SizedBox(height: 24.h),

          // Info Cards Container
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.surfaceBackground,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              children: [
                UserProfileInfoRow(
                  icon: Icons.tag,
                  label: 'User ID',
                  value: '#${user.id}',
                  onCopy: () => _copyToClipboard(context, '#${user.id}', 'User ID'),
                ),
                const Divider(color: AppColors.borderLight),
                UserProfileInfoRow(
                  icon: Icons.email_outlined,
                  label: 'Email Address',
                  value: user.email,
                  onCopy: () => _copyToClipboard(context, user.email, 'Email'),
                ),
                const Divider(color: AppColors.borderLight),
                UserProfileInfoRow(
                  icon: Icons.admin_panel_settings_outlined,
                  label: 'Assigned Role',
                  value: user.role.toUpperCase(),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Close Button
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.goldAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
              child: Text(
                AppStrings.close,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
