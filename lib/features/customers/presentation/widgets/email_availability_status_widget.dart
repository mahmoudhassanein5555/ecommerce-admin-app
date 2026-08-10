import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_state.dart';
import 'package:flutter/material.dart';

class EmailAvailabilityStatusWidget extends StatelessWidget {
  final CustomersState state;
  final bool? isEmailAvailable;

  const EmailAvailabilityStatusWidget({
    super.key,
    required this.state,
    required this.isEmailAvailable,
  });

  @override
  Widget build(BuildContext context) {
    if (state is EmailAvailabilityLoading) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.goldAccent,
          ),
        ),
      );
    }

    if (isEmailAvailable == true) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Icon(Icons.check_circle, color: AppColors.onlineGreen, size: 20),
      );
    }

    if (isEmailAvailable == false) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Icon(Icons.cancel, color: AppColors.red, size: 20),
      );
    }

    return const SizedBox.shrink();
  }
}
