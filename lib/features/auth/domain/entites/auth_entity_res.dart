import 'package:meta/meta.dart';

@immutable
class LoginEntityRes {
  final String accessToken;
  final String refreshToken;

  const LoginEntityRes({this.accessToken = "", this.refreshToken = ""});
}
