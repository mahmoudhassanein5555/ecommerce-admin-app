import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailAvailabilityFeedbackBanner extends StatelessWidget {
  final CustomersState state;
  final bool? isEmailAvailable;

  const EmailAvailabilityFeedbackBanner({
    super.key,
    required this.state,
    required this.isEmailAvailable,
  });

  @override
  Widget build(BuildContext context) {
    if (state is EmailAvailabilityLoading) {
      return Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Text(
          AppStrings.checkingEmailText,
          style: TextStyle(
            fontSize: 11.sp,
            color: AppColors.loaderAmber,
          ),
        ),
      );
    }

    if (isEmailAvailable == true) {
      return Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Text(
          AppStrings.emailAvailableText,
          style: TextStyle(
            fontSize: 11.sp,
            color: AppColors.onlineGreen,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    if (isEmailAvailable == false) {
      return Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Text(
          AppStrings.emailTakenText,
          style: TextStyle(
            fontSize: 11.sp,
            color: AppColors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
