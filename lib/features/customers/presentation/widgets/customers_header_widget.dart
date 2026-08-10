import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_bloc.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_event.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_state.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/add_admin_dialog.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/role_filter_chip.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/users_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomersHeaderWidget extends StatefulWidget {
  const CustomersHeaderWidget({super.key});

  @override
  State<CustomersHeaderWidget> createState() => _CustomersHeaderWidgetState();
}

class _CustomersHeaderWidgetState extends State<CustomersHeaderWidget> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersBloc, CustomersState>(
      buildWhen: (prev, curr) => curr is GetUsersSuccess,
      builder: (context, state) {
        String? selectedRole;
        if (state is GetUsersSuccess) {
          selectedRole = state.selectedRole;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Title, Subtitle, and Add Admin Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.usersManagement,
                      style: TextStyle(
                        color: AppColors.textBrown,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SwiftBuyHeading',
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      AppStrings.manageUsersSubheadline,
                      style: TextStyle(
                        color: AppColors.textBrown.withValues(alpha: 0.8),
                        fontSize: 12.sp,
                        fontFamily: 'SwiftBuyBody',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<CustomersBloc>().add(const GetUsersEvent());
                      },
                      icon: const Icon(Icons.refresh, color: AppColors.goldAccent),
                      tooltip: AppStrings.reloadUsers,
                    ),
                    SizedBox(width: 8.w),
                    ElevatedButton.icon(
                      onPressed: () {
                        AddAdminDialog.show(context);
                      },
                      icon: Icon(Icons.add, color: Colors.white, size: 18.r),
                      label: Text(
                        AppStrings.addNewAdmin,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.goldAccent,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Controls Row: Search Input & Role Filter Chips
            Row(
              children: [
                Expanded(
                  child: UsersSearchField(
                    controller: _searchController,
                    onChanged: (query) {
                      context.read<CustomersBloc>().add(SearchUsersEvent(query));
                    },
                    onClear: () {
                      _searchController.clear();
                      context.read<CustomersBloc>().add(const SearchUsersEvent(''));
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                RoleFilterChip(
                  label: AppStrings.allUsers,
                  isSelected: selectedRole == null,
                  onTap: () {
                    context.read<CustomersBloc>().add(const FilterUsersByRoleEvent(null));
                  },
                ),
                SizedBox(width: 8.w),
                RoleFilterChip(
                  label: AppStrings.adminsOnly,
                  isSelected: selectedRole == 'admin',
                  onTap: () {
                    context.read<CustomersBloc>().add(const FilterUsersByRoleEvent('admin'));
                  },
                ),
                SizedBox(width: 8.w),
                RoleFilterChip(
                  label: AppStrings.customersOnly,
                  isSelected: selectedRole == 'customer',
                  onTap: () {
                    context.read<CustomersBloc>().add(const FilterUsersByRoleEvent('customer'));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
