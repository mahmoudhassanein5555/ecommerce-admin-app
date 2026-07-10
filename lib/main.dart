import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_app/core/dashboar_layout/presentation/view/dashboard_screen.dart';
import 'package:ecommerce_admin_app/core/di/servicelocator.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view/login_screen.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view_model/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_core/firebase_core.dart'; // ➔ لازم تعمل Import للـ core الأول

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. ➔ لازم تهيأ الفايربيز الأول وتباصي الـ Options بتاعة الـ Web
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAvj4Nkzoffq8AcQz7AVsVvoYrt6H8wXA",
      appId: "1:600306558218:web:59195d6d35dbeeb1fdc6f3",
      messagingSenderId: "600306558218",
      projectId: "swiftbuy-54d7a",
      storageBucket: "swiftbuy-54d7a.firebasestorage.app",
      measurementId: "G-MW20QJYFVX",
    ),
  );

  // 2. ➔ بعد ما الفايربيز قام، تقدر تنادي على الـ Firestore يمسح الكاش عادي جداً
  // await FirebaseFirestore.instance.clearPersistence();

  // 3. تهيئة الـ Dependency Injection بتاعك
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SwiftBuy Admin',
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'SwiftBuyBody',
            scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          ),
          home: child,
        );
      },
      child: const LoginScreen(),
    );
  }
}
