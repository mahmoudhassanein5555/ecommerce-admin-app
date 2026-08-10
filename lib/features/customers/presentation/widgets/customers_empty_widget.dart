import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomersEmptyWidget extends StatelessWidget {
  final bool hasFilters;
  final VoidCallback onReset;

  const CustomersEmptyWidget({
    super.key,
    required this.hasFilters,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 72.r,
            color: AppColors.grey400,
          ),
          SizedBox(height: 16.h),
          Text(
            AppStrings.noUsersFoundTitle,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            AppStrings.noUsersFoundSubtitle,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.textSecondary,
            ),
          ),
          if (hasFilters) ...[
            SizedBox(height: 16.h),
            TextButton(
              onPressed: onReset,
              child: const Text('Reset Search & Filters'),
            ),
          ],
        ],
      ),
    );
  }
}
