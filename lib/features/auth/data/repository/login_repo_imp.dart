import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/errors/error_handler.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/auth/data/datasources/login_data_source.dart';
import 'package:ecommerce_admin_app/features/auth/data/models/profile_data_dto.dart';
import 'package:ecommerce_admin_app/features/auth/domain/entites/auth_entity_req.dart';
import 'package:ecommerce_admin_app/features/auth/domain/entites/auth_entity_res.dart';
import 'package:ecommerce_admin_app/features/auth/domain/entites/profile_entity.dart';
import 'package:ecommerce_admin_app/features/auth/domain/repositories/login_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoginRepo)
class LoginRepoImp implements LoginRepo {
  final LoginDataSource loginDataSource;

  LoginRepoImp({required this.loginDataSource});

  @override
  Future<Either<Failure, LoginEntityRes>> login(
    LoginEntityReq loginEntityReq,
  ) async {
    final ConnectivityResult connectivityResult = await (Connectivity()
        .checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return left(Failure("No internet connection"));
    } else {
      try {
        var response = await loginDataSource.login(loginEntityReq.toDto());
        return right(response.toEntity());
      } catch (e) {
        return left(ErrorHandler.handle(e));
      }
    }
  }

  @override
  Future<Either<Failure, ProfileDataEntity>> profileData() async {
    final ConnectivityResult connectivityResult = await (Connectivity()
        .checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return left(Failure("No internet connection"));
    } else {
      try {
        var response = await loginDataSource.profileData();
        return right(response.toEntity());
      } catch (e) {
        return left(ErrorHandler.handle(e));
      }
    }
  }
}
