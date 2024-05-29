import 'package:clean_architecture/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    super.email,
    super.phone,
    super.name,
    super.photoUrl,
    super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      createdAt:
          json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'name': name,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"] ?? "",
      email: map["email"],
      phone: map["phone"],
      name: map["name"],
      photoUrl: map["photoUrl"],
      createdAt: map["createdAt"] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      phone: phone,
      name: name,
      photoUrl: photoUrl,
      createdAt: createdAt,
    );
  }
}
