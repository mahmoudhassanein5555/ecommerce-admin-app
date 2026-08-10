import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/errors/error_handler.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/core/network/connection_checker.dart';
import 'package:ecommerce_admin_app/features/customers/data/datasources/users_remote_data_source.dart';
import 'package:ecommerce_admin_app/features/customers/data/models/create_user_request_dto.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/create_user_request_entity.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';
import 'package:ecommerce_admin_app/features/customers/domain/repositories/users_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UsersRepo)
class UsersRepoImp implements UsersRepo {
  final UsersRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UsersRepoImp(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    if (!await networkInfo.isConnected) {
      return left(Failure('No internet connection'));
    }
    try {
      final response = await remoteDataSource.getUsers();
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(int id) async {
    if (!await networkInfo.isConnected) {
      return left(Failure('No internet connection'));
    }
    try {
      final response = await remoteDataSource.getUserById(id);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmailAvailability(String email) async {
    if (!await networkInfo.isConnected) {
      return left(Failure('No internet connection'));
    }
    try {
      final response = await remoteDataSource.checkEmailAvailability(email);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> createUser(
    CreateUserRequestEntity request,
  ) async {
    if (!await networkInfo.isConnected) {
      return left(Failure('No internet connection'));
    }
    try {
      final dto = CreateUserRequestDto.fromEntity(request);
      final response = await remoteDataSource.createUser(dto);
      return right(response);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
