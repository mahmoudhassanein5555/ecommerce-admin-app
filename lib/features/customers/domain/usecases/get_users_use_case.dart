import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';
import 'package:ecommerce_admin_app/features/customers/domain/repositories/users_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUsersUseCase {
  final UsersRepo repo;

  GetUsersUseCase(this.repo);

  Future<Either<Failure, List<UserEntity>>> invoke() => repo.getUsers();
}
