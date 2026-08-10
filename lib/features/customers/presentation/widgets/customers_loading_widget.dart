import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomersLoadingWidget extends StatelessWidget {
  const CustomersLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 260.w,
        height: 260.h,
        child: Lottie.asset('assets/animations/loading.json'),
      ),
    );
  }
}
