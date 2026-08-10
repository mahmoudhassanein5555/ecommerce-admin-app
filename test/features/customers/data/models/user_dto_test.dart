import 'package:ecommerce_admin_app/features/customers/data/models/create_user_request_dto.dart';
import 'package:ecommerce_admin_app/features/customers/data/models/user_dto.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/create_user_request_entity.dart';
import 'package:ecommerce_admin_app/features/customers/domain/entites/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserDto', () {
    final tJson = {
      'id': 1,
      'email': 'john@mail.com',
      'password': 'changeme',
      'name': 'Jhon',
      'role': 'customer',
      'avatar': 'https://i.imgur.com/LDOO4Qs.jpg',
    };

    test('should be a subclass of UserEntity', () {
      const tUserDto = UserDto(
        id: 1,
        email: 'john@mail.com',
        password: 'changeme',
        name: 'Jhon',
        role: 'customer',
        avatar: 'https://i.imgur.com/LDOO4Qs.jpg',
      );
      expect(tUserDto, isA<UserEntity>());
    });

    test('fromJson should parse valid JSON correctly', () {
      final result = UserDto.fromJson(tJson);

      expect(result.id, 1);
      expect(result.email, 'john@mail.com');
      expect(result.password, 'changeme');
      expect(result.name, 'Jhon');
      expect(result.role, 'customer');
      expect(result.avatar, 'https://i.imgur.com/LDOO4Qs.jpg');
    });

    test('fromJson should safely handle null or missing fields', () {
      final result = UserDto.fromJson({});

      expect(result.id, 0);
      expect(result.email, '');
      expect(result.password, '');
      expect(result.name, '');
      expect(result.role, '');
      expect(result.avatar, '');
    });

    test('toJson should return a JSON map containing proper data', () {
      const tUserDto = UserDto(
        id: 1,
        email: 'john@mail.com',
        password: 'changeme',
        name: 'Jhon',
        role: 'customer',
        avatar: 'https://i.imgur.com/LDOO4Qs.jpg',
      );

      final result = tUserDto.toJson();

      expect(result, tJson);
    });
  });

  group('CreateUserRequestDto', () {
    test('toJson should return correct request body map', () {
      const requestDto = CreateUserRequestDto(
        name: 'Nicolas',
        email: 'nico@gmail.com',
        password: '1234',
        avatar: 'https://picsum.photos/800',
        role: 'admin',
      );

      final result = requestDto.toJson();

      expect(result, {
        'name': 'Nicolas',
        'email': 'nico@gmail.com',
        'password': '1234',
        'avatar': 'https://picsum.photos/800',
        'role': 'admin',
      });
    });

    test('fromEntity should convert CreateUserRequestEntity to CreateUserRequestDto', () {
      const entity = CreateUserRequestEntity(
        name: 'Nicolas',
        email: 'nico@gmail.com',
        password: '1234',
        avatar: 'https://picsum.photos/800',
        role: 'admin',
      );

      final dto = CreateUserRequestDto.fromEntity(entity);

      expect(dto.name, entity.name);
      expect(dto.email, entity.email);
      expect(dto.password, entity.password);
      expect(dto.avatar, entity.avatar);
      expect(dto.role, entity.role);
    });
  });
}
