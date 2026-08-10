import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/errors/error.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/core/network/connection_checker.dart';
import 'package:ecommerce_admin_app/features/customers/data/datasources/users_remote_data_source.dart';
import 'package:ecommerce_admin_app/features/customers/data/models/create_user_request_dto.dart';
import 'package:ecommerce_admin_app/features/customers/data/models/user_dto.dart';
import 'package:ecommerce_admin_app/features/customers/data/repository/users_repo_imp.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/create_user_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeNetworkInfo implements NetworkInfo {
  bool isConnectedValue = true;

  @override
  Future<bool> get isConnected async => isConnectedValue;
}

class FakeUsersRemoteDataSource implements UsersRemoteDataSource {
  List<UserDto>? getUsersResult;
  UserDto? getUserByIdResult;
  bool? checkEmailResult;
  UserDto? createUserResult;

  Exception? errorToThrow;

  @override
  Future<List<UserDto>> getUsers() async {
    if (errorToThrow != null) throw errorToThrow!;
    return getUsersResult!;
  }

  @override
  Future<UserDto> getUserById(int id) async {
    if (errorToThrow != null) throw errorToThrow!;
    return getUserByIdResult!;
  }

  @override
  Future<bool> checkEmailAvailability(String email) async {
    if (errorToThrow != null) throw errorToThrow!;
    return checkEmailResult!;
  }

  @override
  Future<UserDto> createUser(CreateUserRequestDto request) async {
    if (errorToThrow != null) throw errorToThrow!;
    return createUserResult!;
  }
}

void main() {
  late FakeUsersRemoteDataSource fakeRemoteDataSource;
  late FakeNetworkInfo fakeNetworkInfo;
  late UsersRepoImp repository;

  setUp(() {
    fakeRemoteDataSource = FakeUsersRemoteDataSource();
    fakeNetworkInfo = FakeNetworkInfo();
    repository = UsersRepoImp(fakeRemoteDataSource, fakeNetworkInfo);
  });

  const tUser = UserDto(
    id: 1,
    name: 'Jhon',
    email: 'john@mail.com',
    password: 'changeme',
    role: 'customer',
    avatar: 'https://i.imgur.com/LDOO4Qs.jpg',
  );

  group('getUsers', () {
    test('should return Failure when there is no internet connection', () async {
      fakeNetworkInfo.isConnectedValue = false;

      final result = await repository.getUsers();

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure.failuremessage, 'No internet connection'),
        (_) => fail('Should return left'),
      );
    });

    test('should return Right(List<UserEntity>) on remote success', () async {
      fakeNetworkInfo.isConnectedValue = true;
      fakeRemoteDataSource.getUsersResult = [tUser];

      final result = await repository.getUsers();

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Should return right'),
        (users) {
          expect(users.length, 1);
          expect(users.first.email, 'john@mail.com');
        },
      );
    });

    test('should return Left(Failure) on RemoteException', () async {
      fakeNetworkInfo.isConnectedValue = true;
      fakeRemoteDataSource.errorToThrow = RemoteException('Server error');

      final result = await repository.getUsers();

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<Failure>()),
        (_) => fail('Should return left'),
      );
    });
  });

  group('getUserById', () {
    test('should return Failure when offline', () async {
      fakeNetworkInfo.isConnectedValue = false;

      final result = await repository.getUserById(1);

      expect(result.isLeft(), true);
    });

    test('should return Right(UserEntity) on success', () async {
      fakeNetworkInfo.isConnectedValue = true;
      fakeRemoteDataSource.getUserByIdResult = tUser;

      final result = await repository.getUserById(1);

      expect(result, const Right(tUser));
    });

    test('should return Left(Failure) on error', () async {
      fakeNetworkInfo.isConnectedValue = true;
      fakeRemoteDataSource.errorToThrow = RemoteException('404 Not Found');

      final result = await repository.getUserById(99);

      expect(result.isLeft(), true);
    });
  });

  group('checkEmailAvailability', () {
    test('should return Failure when offline', () async {
      fakeNetworkInfo.isConnectedValue = false;

      final result = await repository.checkEmailAvailability('nico@gmail.com');

      expect(result.isLeft(), true);
    });

    test('should return Right(bool) when online and successful', () async {
      fakeNetworkInfo.isConnectedValue = true;
      fakeRemoteDataSource.checkEmailResult = true;

      final result = await repository.checkEmailAvailability('nico@gmail.com');

      expect(result, const Right(true));
    });
  });

  group('createUser', () {
    const tRequest = CreateUserRequestEntity(
      name: 'Nicolas',
      email: 'nico@gmail.com',
      password: '1234',
      avatar: 'https://picsum.photos/800',
      role: 'admin',
    );

    test('should return Failure when offline', () async {
      fakeNetworkInfo.isConnectedValue = false;

      final result = await repository.createUser(tRequest);

      expect(result.isLeft(), true);
    });

    test('should return Right(UserEntity) on success', () async {
      fakeNetworkInfo.isConnectedValue = true;
      fakeRemoteDataSource.createUserResult = const UserDto(
        id: 24,
        name: 'Nicolas',
        email: 'nico@gmail.com',
        password: '1234',
        avatar: 'https://picsum.photos/800',
        role: 'admin',
      );

      final result = await repository.createUser(tRequest);

      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Should return right'),
        (user) => expect(user.id, 24),
      );
    });
  });
}
