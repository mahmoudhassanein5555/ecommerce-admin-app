import 'package:ecommerce_admin_app/core/common/widgets/device_guard.dart';
import 'package:ecommerce_admin_app/core/di/servicelocator.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view/login_screen.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view_model/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
          builder: (context, child) {
            return DeviceGuard(child: child ?? const SizedBox());
          },
          home: BlocProvider(
            create: (context) => getIt<LoginBloc>(),
            child: const LoginScreen(),
          ),
        );
      },
    );
  }
}
