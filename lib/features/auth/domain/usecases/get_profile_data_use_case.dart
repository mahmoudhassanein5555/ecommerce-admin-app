import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/auth/domain/entites/profile_entity.dart';
import 'package:ecommerce_admin_app/features/auth/domain/repositories/login_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetProfileDataUseCase {
  final LoginRepo authRepo;

  GetProfileDataUseCase({required this.authRepo});

  Future<Either<Failure, ProfileDataEntity>> invoke() async {
    return await authRepo.profileData();
  }
}
