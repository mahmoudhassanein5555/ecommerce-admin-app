import 'package:ecommerce_admin_app/core/dashboar_layout/presentation/view/dashboard_screen.dart';
import 'package:ecommerce_admin_app/core/di/servicelocator.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view/login_screen.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view_model/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwiftBuy Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'SwiftBuyBody',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      // home: BlocProvider(
      //   create: (context) => getIt<LoginBloc>(),
      //   child: const LoginScreen(),
      // ),
      home: const DashboardScreen(),
      //  BlocProvider(
      //   create: (context) => getIt<LoginBloc>(),
      //   child: const LoginScreen(),
      // ),
    );
  }
}
