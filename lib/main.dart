import 'package:ecommerce_admin_app/core/dashboar_layout/presentation/view/dashboard_screen.dart';
import 'package:ecommerce_admin_app/core/di/servicelocator.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view/login_screen.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view_model/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        1440,
        900,
      ), // 🖥️ المقاس المثالي للـ Web والـ Tablets
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SwiftBuy Admin', // 🎯 اسم الأبلكيشن المظبوط بتاعك
          theme: ThemeData(
            useMaterial3: true, // ✨ تفعيل الـ Material 3 من كودك القديم
            fontFamily: 'SwiftBuyBody', // 🔤 الخط المخصص بتاع البراند بتاعك
            scaffoldBackgroundColor: const Color(
              0xFFF8F9FA,
            ), // تثبيت خلفية السكافولد
            // textTheme: Typography.englishLike2018.apply(
            //   fontSizeFactor: 1.sp,
            // ), // دمج الـ sp للخطوط كلها بشكل ديناميكي
          ),
          home: child,
        );
      },
      child: const DashboardScreen(),
    );
  }
}
