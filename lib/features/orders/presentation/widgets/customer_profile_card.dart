import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerProfileCard extends StatelessWidget {
  final String customerName;
  final String email;
  final String phone;

  const CustomerProfileCard({
    super.key,
    required this.customerName,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: AppColors.infoBlue,
                child: Text(
                  customerName
                      .split(' ')
                      .map((part) => part.isNotEmpty ? part[0] : '')
                      .take(2)
                      .join(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.actionBlue,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textStrong,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      AppStrings.customerProfile,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.iconSlate,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Icon(
                Icons.email_outlined,
                size: 18.w,
                color: AppColors.actionBlue,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  email,
                  style: TextStyle(fontSize: 13.sp, color: AppColors.textMuted),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                size: 18.w,
                color: AppColors.actionBlue,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  phone,
                  style: TextStyle(fontSize: 13.sp, color: AppColors.textMuted),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            AppStrings.shippingAddress,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textStrong,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            '248 Swift Avenue\nSan Francisco, CA 94107\nUnited States',
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.iconSlate,
              height: 1.6,
            ),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonColor,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                AppStrings.viewFullCustomerProfile,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
