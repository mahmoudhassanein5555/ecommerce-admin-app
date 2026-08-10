import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserRoleBadge extends StatelessWidget {
  final String role;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  const UserRoleBadge({
    super.key,
    required this.role,
    this.fontSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedRole = role.toLowerCase().trim();
    final isAdmin = normalizedRole == 'admin';

    final bgColor = isAdmin
        ? const Color(0xFFFEF3C7) // Amber/Gold soft tint
        : const Color(0xFFEFF6FF); // Blue soft tint
    final textColor = isAdmin
        ? const Color(0xFF92400E) // Deep Amber/Brown
        : const Color(0xFF1D4ED8); // Deep Blue
    final borderColor = isAdmin
        ? const Color(0xFFFDE68A)
        : const Color(0xFFBFDBFE);
    final icon = isAdmin ? Icons.shield_outlined : Icons.person_outline;
    final displayLabel = isAdmin ? 'Admin' : (normalizedRole == 'customer' ? 'Customer' : role);

    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: (fontSize ?? 12.sp) + 2,
            color: textColor,
          ),
          SizedBox(width: 4.w),
          Text(
            displayLabel,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize ?? 12.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'SwiftBuyBody',
            ),
          ),
        ],
      ),
    );
  }
}
