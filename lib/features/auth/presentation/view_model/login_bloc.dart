import 'package:ecommerce_admin_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view_model/login_event.dart';
import 'package:ecommerce_admin_app/features/auth/presentation/view_model/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    final loginEntityReq = event.loginEntityReq;

    emit(LoginLoading());
    final result = await loginUseCase.invoke(loginEntityReq);
    result.fold(
      (failure) => emit(LoginFailure(errorMessage: failure.failuremessage)),
      (response) => emit(LoginSuccess(response: response)),
    );
  }
}
