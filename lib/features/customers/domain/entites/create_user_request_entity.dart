class CreateUserRequestEntity {
  final String name;
  final String email;
  final String password;
  final String avatar;
  final String role;

  const CreateUserRequestEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.avatar,
    this.role = 'admin',
  });
}
