import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailPlaceholder extends StatelessWidget {
  const OrderDetailPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 52.h, horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 65.w,
            color: AppColors.borderMuted,
          ),
          SizedBox(height: 20.h),
          Text(
            AppStrings.noOrderSelectedTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDarkSlate,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            AppStrings.noOrderSelectedSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp, color: AppColors.iconSlate),
          ),
        ],
      ),
    );
  }
}
