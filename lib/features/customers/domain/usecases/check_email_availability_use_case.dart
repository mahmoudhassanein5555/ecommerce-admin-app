import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/customers/domain/repositories/users_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckEmailAvailabilityUseCase {
  final UsersRepo repo;

  CheckEmailAvailabilityUseCase(this.repo);

  Future<Either<Failure, bool>> invoke(String email) =>
      repo.checkEmailAvailability(email);
}
