import 'package:ecommerce_admin_app/features/auth/data/models/auth_dto_req.dart';
import 'package:ecommerce_admin_app/features/auth/data/models/auth_dto_res.dart';

abstract class LoginDataSource {
  Future<LoginDtoRes> login(LoginDtoReq loginDtoReq);
}
