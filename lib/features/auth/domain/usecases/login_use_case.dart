import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/auth/domain/entites/auth_entity_req.dart';
import 'package:ecommerce_admin_app/features/auth/domain/entites/auth_entity_res.dart';
import 'package:ecommerce_admin_app/features/auth/domain/repositories/login_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final LoginRepo authRepo;

  LoginUseCase({required this.authRepo});

  Future<Either<Failure, LoginEntityRes>> invoke(
    LoginEntityReq loginEntityReq,
  ) async {
    return await authRepo.login(loginEntityReq);
  }
}
