import 'package:ecommerce_admin_app/features/auth/domain/entites/auth_entity_req.dart';
import 'package:meta/meta.dart';

@immutable
class LoginDtoReq {
  final String? email;
  final String? password;

  const LoginDtoReq({this.email, this.password});

  factory LoginDtoReq.fromJson(Map<String, dynamic> json) {
    return LoginDtoReq(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  //toEntity
  LoginEntityReq toEntity() {
    return LoginEntityReq(email: email ?? "", password: password ?? "");
  }
}
