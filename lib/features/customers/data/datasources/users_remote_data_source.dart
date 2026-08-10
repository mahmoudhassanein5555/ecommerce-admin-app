import 'package:ecommerce_admin_app/features/customers/data/models/create_user_request_dto.dart';
import 'package:ecommerce_admin_app/features/customers/data/models/user_dto.dart';

abstract class UsersRemoteDataSource {
  Future<List<UserDto>> getUsers();
  Future<UserDto> getUserById(int id);
  Future<bool> checkEmailAvailability(String email);
  Future<UserDto> createUser(CreateUserRequestDto request);
}
