import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_bloc.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_event.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_state.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/user_profile_content.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/user_profile_error_widget.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/widgets/user_profile_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileDialog extends StatefulWidget {
  final int userId;
  final UserEntity? initialUser;

  const UserProfileDialog({
    super.key,
    required this.userId,
    this.initialUser,
  });

  static Future<void> show(
    BuildContext context, {
    required int userId,
    UserEntity? initialUser,
  }) {
    final bloc = BlocProvider.of<CustomersBloc>(context);
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: bloc,
          child: UserProfileDialog(
            userId: userId,
            initialUser: initialUser,
          ),
        );
      },
    );
  }

  @override
  State<UserProfileDialog> createState() => _UserProfileDialogState();
}

class _UserProfileDialogState extends State<UserProfileDialog> {
  @override
  void initState() {
    super.initState();
    context.read<CustomersBloc>().add(GetUserByIdEvent(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 520.w, maxHeight: 680.h),
        child: Padding(
          padding: EdgeInsets.all(28.0.r),
          child: BlocBuilder<CustomersBloc, CustomersState>(
            buildWhen: (prev, curr) =>
                curr is UserProfileLoading ||
                curr is UserProfileSuccess ||
                curr is UserProfileError,
            builder: (context, state) {
              if (state is UserProfileLoading) {
                if (widget.initialUser != null) {
                  return UserProfileContent(user: widget.initialUser!, isLoading: true);
                }
                return const UserProfileLoadingWidget();
              }

              if (state is UserProfileError) {
                if (widget.initialUser != null) {
                  return UserProfileContent(user: widget.initialUser!);
                }
                return UserProfileErrorWidget(
                  message: state.message,
                  onRetry: () {
                    context.read<CustomersBloc>().add(GetUserByIdEvent(widget.userId));
                  },
                );
              }

              if (state is UserProfileSuccess) {
                return UserProfileContent(user: state.user);
              }

              if (widget.initialUser != null) {
                return UserProfileContent(user: widget.initialUser!);
              }

              return const UserProfileLoadingWidget();
            },
          ),
        ),
      ),
    );
  }
}
