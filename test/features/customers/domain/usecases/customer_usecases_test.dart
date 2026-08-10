import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/create_user_request_entity.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';
import 'package:ecommerce_admin_app/features/customers/domain/repositories/users_repo.dart';
import 'package:ecommerce_admin_app/features/customers/domain/usecases/check_email_availability_use_case.dart';
import 'package:ecommerce_admin_app/features/customers/domain/usecases/create_user_use_case.dart';
import 'package:ecommerce_admin_app/features/customers/domain/usecases/get_user_by_id_use_case.dart';
import 'package:ecommerce_admin_app/features/customers/domain/usecases/get_users_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeUsersRepo implements UsersRepo {
  Either<Failure, List<UserEntity>>? getUsersResult;
  Either<Failure, UserEntity>? getUserByIdResult;
  Either<Failure, bool>? checkEmailResult;
  Either<Failure, UserEntity>? createUserResult;

  int? lastRequestedId;
  String? lastCheckedEmail;
  CreateUserRequestEntity? lastCreateRequest;

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    return getUsersResult!;
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(int id) async {
    lastRequestedId = id;
    return getUserByIdResult!;
  }

  @override
  Future<Either<Failure, bool>> checkEmailAvailability(String email) async {
    lastCheckedEmail = email;
    return checkEmailResult!;
  }

  @override
  Future<Either<Failure, UserEntity>> createUser(
    CreateUserRequestEntity request,
  ) async {
    lastCreateRequest = request;
    return createUserResult!;
  }
}

void main() {
  late FakeUsersRepo fakeRepo;

  setUp(() {
    fakeRepo = FakeUsersRepo();
  });

  const tUser = UserEntity(
    id: 1,
    name: 'Jhon',
    email: 'john@mail.com',
    role: 'customer',
  );

  test('GetUsersUseCase should call repo.getUsers()', () async {
    fakeRepo.getUsersResult = const Right([tUser]);
    final useCase = GetUsersUseCase(fakeRepo);

    final result = await useCase.invoke();

    expect(result, const Right([tUser]));
  });

  test('GetUserByIdUseCase should call repo.getUserById(id)', () async {
    fakeRepo.getUserByIdResult = const Right(tUser);
    final useCase = GetUserByIdUseCase(fakeRepo);

    final result = await useCase.invoke(1);

    expect(fakeRepo.lastRequestedId, 1);
    expect(result, const Right(tUser));
  });

  test('CheckEmailAvailabilityUseCase should call repo.checkEmailAvailability(email)', () async {
    fakeRepo.checkEmailResult = const Right(true);
    final useCase = CheckEmailAvailabilityUseCase(fakeRepo);

    final result = await useCase.invoke('test@mail.com');

    expect(fakeRepo.lastCheckedEmail, 'test@mail.com');
    expect(result, const Right(true));
  });

  test('CreateUserUseCase should call repo.createUser(request)', () async {
    const tRequest = CreateUserRequestEntity(
      name: 'Nicolas',
      email: 'nico@gmail.com',
      password: '1234',
      avatar: 'https://picsum.photos/800',
      role: 'admin',
    );
    fakeRepo.createUserResult = const Right(tUser);
    final useCase = CreateUserUseCase(fakeRepo);

    final result = await useCase.invoke(tRequest);

    expect(fakeRepo.lastCreateRequest, tRequest);
    expect(result, const Right(tUser));
  });
}
