import 'package:ecommerce_admin_app/features/auth/domain/entites/profile_entity.dart';

class ProfileDataDto extends ProfileDataEntity {
  ProfileDataDto({
    super.id,
    super.email,
    super.password,
    super.name,
    super.role,
    super.avatar,
  });

  ProfileDataDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['role'] = role;
    data['avatar'] = avatar;

    return data;
  }

  //toEntity
  ProfileDataEntity toEntity() {
    return ProfileDataEntity(
      id: id,
      email: email,
      password: password,
      name: name,
      role: role,
    );
  }
}
