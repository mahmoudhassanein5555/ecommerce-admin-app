import 'package:ecommerce_admin_app/features/auth/domain/entites/auth_entity_req.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final LoginEntityReq loginEntityReq;
  const LoginButtonPressed({required this.loginEntityReq});

  @override
  List<Object?> get props => [loginEntityReq];
}

class ProfileDataEvent extends LoginEvent {}
