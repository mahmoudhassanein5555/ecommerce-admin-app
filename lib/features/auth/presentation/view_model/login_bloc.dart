// import 'package:ecommerce_admin_app/features/auth/domain/usecases/login_use_case.dart';
// import 'package:ecommerce_admin_app/features/auth/presentation/view_model/login_event.dart';
// import 'package:ecommerce_admin_app/features/auth/presentation/view_model/login_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';

// @injectable
// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final LoginUseCase loginUseCase;
//   LoginBloc(this.loginUseCase) : super(LoginInitial()) {
//     on<LoginButtonPressed>(_onLoginButtonPressed);
//   }

//   Future<void> _onLoginButtonPressed(
//     LoginButtonPressed event,
//     Emitter<LoginState> emit,
//   ) async {
//     final loginEntityReq = event.loginEntityReq;

//     emit(LoginLoading());
//     final result = await loginUseCase.invoke(loginEntityReq);
//     result.fold(
//       (failure) => emit(LoginFailure(errorMessage: failure.failuremessage)),
//       (response) => emit(LoginSuccess(response: response)),
//     );
//   }
// }
import 'package:ecommerce_admin_app/features/auth/domain/usecases/get_profile_data_use_case.dart';
import 'package:ecommerce_admin_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view_model/login_event.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view_model/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final GetProfileDataUseCase getProfileUseCase;

  LoginBloc(this.loginUseCase, this.getProfileUseCase) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    // 1. تنفيذ عملية تسجيل الدخول
    final loginResult = await loginUseCase.invoke(event.loginEntityReq);

    // استخدام await هنا مهم جداً للتأكد من انتهاء العمليات قبل الخروج من الدالة
    await loginResult.fold(
      (failure) async => emit(LoginFailure(errorMessage: failure.failuremessage)),
      (loginResponse) async => await _handleProfileFetch(loginResponse, emit),
    );
  }

  /// 👈 دالة منفصلة ومستقلة تماماً لإدارة عملية جلب البروفايل بعد نجاح اللوجن
  Future<void> _handleProfileFetch(
    dynamic loginResponse, // استبدل dynamic بنوع الـ Response الحقيقي بتاعك لو حابب
    Emitter<LoginState> emit,
  ) async {
    final profileResult = await getProfileUseCase.invoke();

    profileResult.fold(
      (profileFailure) {
        emit(LoginFailure(
          errorMessage: "تم تسجيل الدخول، ولكن فشل جلب بيانات الحساب: ${profileFailure.failuremessage}",
        ));
      },
      (profileResponse) {
        // 🏁 النجاح النهائي بعد اكتمال العمليتين وتخزين الكاش
        emit(LoginSuccess(response: loginResponse));
      },
    );
  }
}