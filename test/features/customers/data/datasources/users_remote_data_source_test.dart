import 'package:dio/dio.dart';
import 'package:ecommerce_admin_app/core/api/api_endpoints.dart';
import 'package:ecommerce_admin_app/core/api/api_manager.dart';
import 'package:ecommerce_admin_app/core/errors/error.dart';
import 'package:ecommerce_admin_app/features/customers/data/datasources/users_remote_data_source_imp.dart';
import 'package:ecommerce_admin_app/features/customers/data/models/create_user_request_dto.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeApiManager extends ApiManager {
  Response? nextGetResponse;
  Response? nextPostResponse;

  String? capturedGetEndPoint;
  String? capturedPostEndPoint;
  Object? capturedPostBody;

  @override
  Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    capturedGetEndPoint = endPoint;
    if (nextGetResponse != null) {
      return nextGetResponse!;
    }
    throw Exception('No response set for getData');
  }

  @override
  Future<Response> postData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    capturedPostEndPoint = endPoint;
    capturedPostBody = body;
    if (nextPostResponse != null) {
      return nextPostResponse!;
    }
    throw Exception('No response set for postData');
  }
}

void main() {
  late FakeApiManager fakeApiManager;
  late UsersRemoteDataSourceImp dataSource;

  setUp(() {
    fakeApiManager = FakeApiManager();
    dataSource = UsersRemoteDataSourceImp(fakeApiManager);
  });

  group('getUsers', () {
    final tUsersListJson = [
      {
        'id': 1,
        'email': 'john@mail.com',
        'password': 'changeme',
        'name': 'Jhon',
        'role': 'customer',
        'avatar': 'https://i.imgur.com/LDOO4Qs.jpg',
      },
      {
        'id': 2,
        'email': 'admin@mail.com',
        'password': 'changeme',
        'name': 'Admin',
        'role': 'admin',
        'avatar': 'https://i.imgur.com/LDOO4Qs.jpg',
      },
    ];

    test('should return List<UserDto> when the response status code is 200', () async {
      fakeApiManager.nextGetResponse = Response(
        data: tUsersListJson,
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiEndpoints.users),
      );

      final result = await dataSource.getUsers();

      expect(fakeApiManager.capturedGetEndPoint, ApiEndpoints.users);
      expect(result.length, 2);
      expect(result.first.email, 'john@mail.com');
      expect(result.last.role, 'admin');
    });

    test('should throw RemoteException when status code is not 200..299', () async {
      fakeApiManager.nextGetResponse = Response(
        data: {'message': 'Server error'},
        statusCode: 500,
        statusMessage: 'Internal Server Error',
        requestOptions: RequestOptions(path: ApiEndpoints.users),
      );

      expect(() => dataSource.getUsers(), throwsA(isA<RemoteException>()));
    });
  });

  group('getUserById', () {
    final tUserJson = {
      'id': 1,
      'email': 'john@mail.com',
      'password': 'changeme',
      'name': 'Jhon',
      'role': 'customer',
      'avatar': 'https://i.imgur.com/LDOO4Qs.jpg',
    };

    test('should return UserDto when the response status code is 200', () async {
      fakeApiManager.nextGetResponse = Response(
        data: tUserJson,
        statusCode: 200,
        requestOptions: RequestOptions(path: '${ApiEndpoints.users}/1'),
      );

      final result = await dataSource.getUserById(1);

      expect(fakeApiManager.capturedGetEndPoint, '${ApiEndpoints.users}/1');
      expect(result.id, 1);
      expect(result.name, 'Jhon');
    });

    test('should throw RemoteException when status code is not 200..299', () async {
      fakeApiManager.nextGetResponse = Response(
        data: {'message': 'User not found'},
        statusCode: 404,
        statusMessage: 'Not Found',
        requestOptions: RequestOptions(path: '${ApiEndpoints.users}/99'),
      );

      expect(() => dataSource.getUserById(99), throwsA(isA<RemoteException>()));
    });
  });

  group('checkEmailAvailability', () {
    test('should return true when isAvailable is true', () async {
      fakeApiManager.nextPostResponse = Response(
        data: {'isAvailable': true},
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiEndpoints.isEmailAvailable),
      );

      final result = await dataSource.checkEmailAvailability('nico@gmail.com');

      expect(fakeApiManager.capturedPostEndPoint, ApiEndpoints.isEmailAvailable);
      expect(result, true);
    });

    test('should return false when isAvailable is false', () async {
      fakeApiManager.nextPostResponse = Response(
        data: {'isAvailable': false},
        statusCode: 200,
        requestOptions: RequestOptions(path: ApiEndpoints.isEmailAvailable),
      );

      final result = await dataSource.checkEmailAvailability('john@mail.com');

      expect(result, false);
    });

    test('should throw RemoteException on error status code', () async {
      fakeApiManager.nextPostResponse = Response(
        data: {'message': 'Bad Request'},
        statusCode: 400,
        statusMessage: 'Bad Request',
        requestOptions: RequestOptions(path: ApiEndpoints.isEmailAvailable),
      );

      expect(
        () => dataSource.checkEmailAvailability('invalid-email'),
        throwsA(isA<RemoteException>()),
      );
    });
  });

  group('createUser', () {
    const tRequest = CreateUserRequestDto(
      name: 'Nicolas',
      email: 'nico@gmail.com',
      password: '1234',
      avatar: 'https://picsum.photos/800',
      role: 'admin',
    );

    final tCreatedUserJson = {
      'id': 24,
      'name': 'Nicolas',
      'email': 'nico@gmail.com',
      'password': '1234',
      'avatar': 'https://picsum.photos/800',
      'role': 'admin',
    };

    test('should return UserDto when user is created successfully', () async {
      fakeApiManager.nextPostResponse = Response(
        data: tCreatedUserJson,
        statusCode: 201,
        requestOptions: RequestOptions(path: ApiEndpoints.users),
      );

      final result = await dataSource.createUser(tRequest);

      expect(fakeApiManager.capturedPostEndPoint, ApiEndpoints.users);
      expect(fakeApiManager.capturedPostBody, tRequest.toJson());
      expect(result.id, 24);
      expect(result.role, 'admin');
    });

    test('should throw RemoteException when creation fails', () async {
      fakeApiManager.nextPostResponse = Response(
        data: {'message': 'Email already exists'},
        statusCode: 400,
        statusMessage: 'Bad Request',
        requestOptions: RequestOptions(path: ApiEndpoints.users),
      );

      expect(() => dataSource.createUser(tRequest), throwsA(isA<RemoteException>()));
    });
  });
}
