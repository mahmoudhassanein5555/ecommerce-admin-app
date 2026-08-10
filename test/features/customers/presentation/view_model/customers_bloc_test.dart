import 'package:dartz/dartz.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/create_user_request_entity.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';
import 'package:ecommerce_admin_app/features/customers/domain/repositories/users_repo.dart';
import 'package:ecommerce_admin_app/features/customers/domain/usecases/check_email_availability_use_case.dart';
import 'package:ecommerce_admin_app/features/customers/domain/usecases/create_user_use_case.dart';
import 'package:ecommerce_admin_app/features/customers/domain/usecases/get_user_by_id_use_case.dart';
import 'package:ecommerce_admin_app/features/customers/domain/usecases/get_users_use_case.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_bloc.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_event.dart';
import 'package:ecommerce_admin_app/features/customers/presentation/view_model/customers_state.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeUsersRepo implements UsersRepo {
  Either<Failure, List<UserEntity>>? getUsersResult;
  Either<Failure, UserEntity>? getUserByIdResult;
  Either<Failure, bool>? checkEmailResult;
  Either<Failure, UserEntity>? createUserResult;

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    return getUsersResult!;
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(int id) async {
    return getUserByIdResult!;
  }

  @override
  Future<Either<Failure, bool>> checkEmailAvailability(String email) async {
    return checkEmailResult!;
  }

  @override
  Future<Either<Failure, UserEntity>> createUser(CreateUserRequestEntity request) async {
    return createUserResult!;
  }
}

void main() {
  late FakeUsersRepo fakeRepo;
  late CustomersBloc bloc;

  setUp(() {
    fakeRepo = FakeUsersRepo();
    bloc = CustomersBloc(
      getUsersUseCase: GetUsersUseCase(fakeRepo),
      getUserByIdUseCase: GetUserByIdUseCase(fakeRepo),
      checkEmailAvailabilityUseCase: CheckEmailAvailabilityUseCase(fakeRepo),
      createUserUseCase: CreateUserUseCase(fakeRepo),
    );
  });

  tearDown(() {
    bloc.close();
  });

  const tCustomer = UserEntity(
    id: 1,
    name: 'John Doe',
    email: 'john@mail.com',
    role: 'customer',
  );

  const tAdmin = UserEntity(
    id: 2,
    name: 'Admin Jane',
    email: 'jane@admin.com',
    role: 'admin',
  );

  test('initial state should be CustomersInitial', () {
    expect(bloc.state, isA<CustomersInitial>());
  });

  group('GetUsersEvent', () {
    test('should emit [CustomersLoading, GetUsersSuccess] on success', () async {
      fakeRepo.getUsersResult = const Right([tCustomer, tAdmin]);

      final expectedStates = [
        isA<CustomersLoading>(),
        isA<GetUsersSuccess>().having(
          (s) => s.filteredUsers.length,
          'filteredUsers.length',
          2,
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const GetUsersEvent());
    });

    test('should emit [CustomersLoading, CustomersError] on failure', () async {
      fakeRepo.getUsersResult = Left(Failure('Failed to load users'));

      final expectedStates = [
        isA<CustomersLoading>(),
        isA<CustomersError>().having(
          (s) => s.message,
          'message',
          'Failed to load users',
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const GetUsersEvent());
    });
  });

  group('SearchUsersEvent & FilterUsersByRoleEvent', () {
    setUp(() async {
      fakeRepo.getUsersResult = const Right([tCustomer, tAdmin]);
      bloc.add(const GetUsersEvent());
      await Future.delayed(const Duration(milliseconds: 10));
    });

    test('should filter users by search query correctly', () async {
      final expected = isA<GetUsersSuccess>().having(
        (s) => s.filteredUsers.first.name,
        'first user name',
        'Admin Jane',
      );

      expectLater(bloc.stream, emits(expected));

      bloc.add(const SearchUsersEvent('Jane'));
    });

    test('should filter users by role correctly', () async {
      final expected = isA<GetUsersSuccess>().having(
        (s) => s.filteredUsers.first.role,
        'first user role',
        'customer',
      );

      expectLater(bloc.stream, emits(expected));

      bloc.add(const FilterUsersByRoleEvent('customer'));
    });
  });

  group('GetUserByIdEvent', () {
    test('should emit [UserProfileLoading, UserProfileSuccess] on success', () async {
      fakeRepo.getUserByIdResult = const Right(tAdmin);

      final expectedStates = [
        isA<UserProfileLoading>(),
        isA<UserProfileSuccess>().having(
          (s) => s.user.id,
          'user.id',
          2,
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const GetUserByIdEvent(2));
    });

    test('should emit [UserProfileLoading, UserProfileError] on failure', () async {
      fakeRepo.getUserByIdResult = Left(Failure('User not found'));

      final expectedStates = [
        isA<UserProfileLoading>(),
        isA<UserProfileError>().having(
          (s) => s.message,
          'message',
          'User not found',
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const GetUserByIdEvent(99));
    });
  });

  group('CheckEmailAvailabilityEvent', () {
    test('should emit [EmailAvailabilityLoading, EmailAvailabilityChecked] when available', () async {
      fakeRepo.checkEmailResult = const Right(true);

      final expectedStates = [
        isA<EmailAvailabilityLoading>(),
        isA<EmailAvailabilityChecked>().having(
          (s) => s.isAvailable,
          'isAvailable',
          true,
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const CheckEmailAvailabilityEvent('newadmin@gmail.com'));
    });

    test('should emit [EmailAvailabilityLoading, EmailAvailabilityChecked(isAvailable: false)] when taken', () async {
      fakeRepo.checkEmailResult = const Right(false);

      final expectedStates = [
        isA<EmailAvailabilityLoading>(),
        isA<EmailAvailabilityChecked>().having(
          (s) => s.isAvailable,
          'isAvailable',
          false,
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const CheckEmailAvailabilityEvent('existing@gmail.com'));
    });
  });

  group('CreateAdminEvent', () {
    const tRequest = CreateUserRequestEntity(
      name: 'Admin Jane',
      email: 'jane@admin.com',
      password: '1234',
      avatar: 'https://picsum.photos/800',
      role: 'admin',
    );

    test('should emit [CreateAdminLoading, CreateAdminSuccess] and trigger GetUsersEvent', () async {
      fakeRepo.createUserResult = const Right(tAdmin);
      fakeRepo.getUsersResult = const Right([tAdmin]);

      final expectedStates = [
        isA<CreateAdminLoading>(),
        isA<CreateAdminSuccess>().having(
          (s) => s.user.name,
          'user.name',
          'Admin Jane',
        ),
        isA<CustomersLoading>(),
        isA<GetUsersSuccess>(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const CreateAdminEvent(tRequest));
    });

    test('should emit [CreateAdminLoading, CreateAdminError] on error', () async {
      fakeRepo.createUserResult = Left(Failure('Email already exists'));

      final expectedStates = [
        isA<CreateAdminLoading>(),
        isA<CreateAdminError>().having(
          (s) => s.message,
          'message',
          'Email already exists',
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(const CreateAdminEvent(tRequest));
    });
  });
}
