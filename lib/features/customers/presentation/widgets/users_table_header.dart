import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/users_table_header_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersTableHeader extends StatelessWidget {
  const UsersTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: const BoxDecoration(
        color: AppColors.surfaceBackground,
        border: Border(bottom: BorderSide(color: AppColors.borderLight)),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 4,
            child: UsersTableHeaderCell(title: 'USER'),
          ),
          Expanded(
            flex: 2,
            child: UsersTableHeaderCell(title: 'USER ID'),
          ),
          Expanded(
            flex: 4,
            child: UsersTableHeaderCell(title: 'EMAIL ADDRESS'),
          ),
          Expanded(
            flex: 2,
            child: UsersTableHeaderCell(title: 'ROLE'),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: UsersTableHeaderCell(title: 'ACTIONS'),
            ),
          ),
        ],
      ),
    );
  }
}
