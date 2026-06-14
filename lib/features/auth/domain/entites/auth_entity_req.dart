import 'package:ecommerce_admin_app/features/auth/data/models/auth_dto_req.dart';
import 'package:meta/meta.dart';

@immutable
class LoginEntityReq {
  final String email;
  final String password;

  const LoginEntityReq({this.email = "", this.password = ""});
  //todto
  LoginDtoReq toDto() {
    return LoginDtoReq(email: email, password: password);
  }
}
