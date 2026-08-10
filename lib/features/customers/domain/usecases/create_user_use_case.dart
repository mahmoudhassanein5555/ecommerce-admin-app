import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/create_user_request_entity.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';
import 'package:ecommerce_admin_app/features/customers/domain/repositories/users_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateUserUseCase {
  final UsersRepo repo;

  CreateUserUseCase(this.repo);

  Future<Either<Failure, UserEntity>> invoke(CreateUserRequestEntity request) =>
      repo.createUser(request);
}
