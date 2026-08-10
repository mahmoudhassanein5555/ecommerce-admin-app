import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';
import 'package:ecommerce_admin_app/features/customers/domain/repositories/users_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserByIdUseCase {
  final UsersRepo repo;

  GetUserByIdUseCase(this.repo);

  Future<Either<Failure, UserEntity>> invoke(int id) => repo.getUserById(id);
}
