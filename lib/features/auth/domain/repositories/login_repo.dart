import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/auth/domain/entites/auth_entity_req.dart';
import 'package:ecommerce_admin_app/features/auth/domain/entites/auth_entity_res.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginEntityRes>> login(LoginEntityReq loginEntityReq);
  // Future<Either<Failure, String>> register(RegisterReqEntity registerReqEntity);
}
