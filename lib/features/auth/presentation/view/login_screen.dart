import 'dart:math' as math;
import 'dart:ui';
import 'package:ecommerce_admin_app/core/utils/app_toasts.dart';
import 'package:ecommerce_admin_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:ecommerce_admin_app/features/auth/domain/entites/auth_entity_req.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view_model/login_bloc.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view_model/login_event.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view_model/login_state.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/widgets/wide_wave_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool val = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFC49A45);
    final darkWaveColor = const Color(0xFF231F20).withOpacity(0.25);
    final lightWaveColor = const Color(0xFFE5C158).withOpacity(0.35);

    return Scaffold(
      backgroundColor: backgroundColor,

      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: WideWavePainter(
                  waveAnimation: _controller,
                  color: lightWaveColor,
                  wavePhase: 0.0,
                  waveHeight: 80,
                  frequency: 1.2,
                ),
              );
            },
          ),

          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: WideWavePainter(
                  waveAnimation: _controller,
                  color: darkWaveColor,
                  wavePhase: math.pi * 0.7,
                  waveHeight: 70,
                  frequency: 1.5,
                ),
              );
            },
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'SwiftBuy Dashboard',
                  style: TextStyle(
                    fontFamily: 'SwiftBuyBrand',
                    fontSize: 54,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff493603),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Login Screen',
                  style: TextStyle(
                    fontFamily: 'SwiftBuyBrand',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  width: 600,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        width: 420,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.25),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontFamily: 'SwiftBuyBody',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomTextFormField(
                              controller: emailController,
                              hintText: 'Enter Your Admin Email',

                              hintTextColor: Colors.white70,
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Password',
                              style: TextStyle(
                                fontFamily: 'SwiftBuyBody',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomTextFormField(
                              controller: passwordController,
                              hintText: 'Enter Your Password',
                              hintTextColor: Colors.white70,
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              isPassword: true,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: const Color(0xff493603),
                                  checkColor: Colors.white,
                                  value: val,
                                  onChanged: (value) {
                                    setState(() {
                                      val = value ?? false;
                                    });
                                  },
                                ),
                                const Text(
                                  'Remember this device',
                                  style: TextStyle(
                                    fontFamily: 'SwiftBuyBody',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: BlocConsumer<LoginBloc, LoginState>(
                                listener: (blocContext, state) {
                                  if (state is LoginSuccess) {
                                    AppToast.showToast(
                                      context: context,
                                      title: 'Login Successful',
                                      description:
                                          'You have been logged in successfully.',
                                      type: ToastificationType.success,
                                    );
                                    isLoading = false;
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Scaffold(
                                          body: Center(
                                            child: Text(
                                              'Login successful',
                                              style: TextStyle(
                                                fontFamily: 'SwiftBuyBrand',
                                                fontSize: 54,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff493603),
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (state is LoginFailure) {
                                    AppToast.showToast(
                                      context: context,
                                      title: 'Login Failed',
                                      description: state.errorMessage,
                                      type: ToastificationType.error,
                                    );
                                    isLoading = false;
                                  } else if (state is LoginLoading) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                builder: (context, state) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF1A1617),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    onPressed: () {
                                      context.read<LoginBloc>().add(
                                        LoginButtonPressed(
                                          loginEntityReq: LoginEntityReq(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                        ),
                                      );
                                    },
                                    child: isLoading
                                        ? const CircularProgressIndicator()
                                        : const Text(
                                            'Login to Dashboard',
                                            style: TextStyle(
                                              fontFamily: 'SwiftBuyBody',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
