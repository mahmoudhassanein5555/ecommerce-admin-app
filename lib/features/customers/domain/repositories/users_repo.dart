import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/create_user_request_entity.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';

abstract class UsersRepo {
  Future<Either<Failure, List<UserEntity>>> getUsers();
  Future<Either<Failure, UserEntity>> getUserById(int id);
  Future<Either<Failure, bool>> checkEmailAvailability(String email);
  Future<Either<Failure, UserEntity>> createUser(
    CreateUserRequestEntity request,
  );
}
