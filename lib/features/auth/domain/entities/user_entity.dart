class UserEntity {
  final String? id;
  final String email;
  final String fullname;
  final String username;
  final String phone;

  UserEntity({
    this.id,
    required this.email,
    required this.fullname,
    required this.username,
    required this.phone,
  });
}
