import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_bloc.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_event.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_state.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/add_admin_dialog.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/customers_empty_widget.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/customers_error_widget.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/customers_header_widget.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/customers_loading_widget.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/users_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CustomersBloc>().add(const GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomersHeaderWidget(),
              SizedBox(height: 24.h),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.goldAccent,
                  onRefresh: () async {
                    context.read<CustomersBloc>().add(const GetUsersEvent());
                  },
                  child: BlocBuilder<CustomersBloc, CustomersState>(
                    buildWhen: (prev, curr) =>
                        curr is CustomersLoading ||
                        curr is CustomersError ||
                        curr is GetUsersSuccess,
                    builder: (context, state) {
                      if (state is CustomersLoading) {
                        return const CustomersLoadingWidget();
                      }

                      if (state is CustomersError) {
                        return CustomersErrorWidget(
                          message: state.message,
                          onRetry: () {
                            context.read<CustomersBloc>().add(
                              const GetUsersEvent(),
                            );
                          },
                        );
                      }

                      if (state is GetUsersSuccess) {
                        if (state.filteredUsers.isEmpty) {
                          return CustomersEmptyWidget(
                            hasFilters:
                                state.searchQuery.isNotEmpty ||
                                state.selectedRole != null,
                            onReset: () {
                              context.read<CustomersBloc>().add(
                                const SearchUsersEvent(''),
                              );
                              context.read<CustomersBloc>().add(
                                const FilterUsersByRoleEvent(null),
                              );
                            },
                          );
                        }

                        return UsersTableWidget(users: state.filteredUsers);
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
