import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/user_table_row.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/users_table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersTableWidget extends StatelessWidget {
  final List<UserEntity> users;

  const UsersTableWidget({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          children: [
            const UsersTableHeader(),
            Expanded(
              child: ListView.separated(
                itemCount: users.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  color: AppColors.divider,
                ),
                itemBuilder: (context, index) {
                  return UserTableRow(user: users[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
