import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersTableHeaderCell extends StatelessWidget {
  final String title;

  const UsersTableHeaderCell({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.tableHeaderText,
        letterSpacing: 0.8,
      ),
    );
  }
}
