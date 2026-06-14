import 'package:ecommerce_admin_app/features/auth/domain/entites/auth_entity_res.dart';
import 'package:meta/meta.dart';

@immutable
class LoginDtoRes {
  final String? accessToken;
  final String? refreshToken;

  const LoginDtoRes({this.accessToken, this.refreshToken});

  factory LoginDtoRes.fromJson(Map<String, dynamic> json) {
    return LoginDtoRes(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }

  //toEntity
  LoginEntityRes toEntity() {
    return LoginEntityRes(
      accessToken: accessToken ?? "",
      refreshToken: refreshToken ?? "",
    );
  }
}
