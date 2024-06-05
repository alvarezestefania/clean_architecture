class UserEntity {
  final String id;
  final String? email;
  final String? phone;
  final String? name;
  final String? photoUrl;
  final DateTime? createdAt;

  UserEntity({
    required this.id,
    this.email,
    this.name,
    this.phone,
    this.photoUrl,
    this.createdAt,
  });
}
