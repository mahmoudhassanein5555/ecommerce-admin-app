import 'package:ecommerce_admin_app/features/auth/domain/entites/auth_entity_res.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  final LoginEntityRes response;
  const LoginSuccess({required this.response});
  @override
  List<Object?> get props => [response];
}

class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}
