import 'package:ecommerce_admin_app/features/customers/domain/entites/create_user_request_entity.dart';

class CreateUserRequestDto extends CreateUserRequestEntity {
  const CreateUserRequestDto({
    required super.name,
    required super.email,
    required super.password,
    required super.avatar,
    super.role = 'admin',
  });

  factory CreateUserRequestDto.fromEntity(CreateUserRequestEntity entity) {
    return CreateUserRequestDto(
      name: entity.name,
      email: entity.email,
      password: entity.password,
      avatar: entity.avatar,
      role: entity.role,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
      'role': role,
    };
  }
}
