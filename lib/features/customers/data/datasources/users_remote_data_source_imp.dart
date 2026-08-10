import 'package:ecommerce_admin_app/core/api/api_endpoints.dart';
import 'package:ecommerce_admin_app/core/api/api_manager.dart';
import 'package:ecommerce_admin_app/core/errors/error.dart';
import 'package:ecommerce_admin_app/features/customers/data/datasources/users_remote_data_source.dart';
import 'package:ecommerce_admin_app/features/customers/data/models/create_user_request_dto.dart';
import 'package:ecommerce_admin_app/features/customers/data/models/user_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UsersRemoteDataSource)
class UsersRemoteDataSourceImp implements UsersRemoteDataSource {
  final ApiManager apiManager;

  UsersRemoteDataSourceImp(this.apiManager);

  @override
  Future<List<UserDto>> getUsers() async {
    final response = await apiManager.getData(endPoint: ApiEndpoints.users);
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      final List<dynamic> res = response.data;
      return res.map((e) => UserDto.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw RemoteException(response.statusMessage ?? 'Unknown error');
    }
  }

  @override
  Future<UserDto> getUserById(int id) async {
    final response = await apiManager.getData(
      endPoint: '${ApiEndpoints.users}/$id',
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return UserDto.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw RemoteException(response.statusMessage ?? 'Unknown error');
    }
  }

  @override
  Future<bool> checkEmailAvailability(String email) async {
    final response = await apiManager.postData(
      endPoint: ApiEndpoints.isEmailAvailable,
      body: {'email': email},
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.data is Map<String, dynamic>) {
        return response.data['isAvailable'] == true;
      } else if (response.data is bool) {
        return response.data as bool;
      }
      return true;
    } else {
      throw RemoteException(response.statusMessage ?? 'Unknown error');
    }
  }

  @override
  Future<UserDto> createUser(CreateUserRequestDto request) async {
    final response = await apiManager.postData(
      endPoint: ApiEndpoints.users,
      body: request.toJson(),
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return UserDto.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw RemoteException(response.statusMessage ?? 'Unknown error');
    }
  }
}
