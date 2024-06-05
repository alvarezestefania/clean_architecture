import 'package:clean_architecture/features/data/user/models/user_model.dart';
import 'package:clean_architecture/features/domain/auth/entities/authdata_entity.dart';
import 'package:clean_architecture/features/domain/user/entities/user_entity.dart';

class AuthDataModel extends AuthDataEntity {
  AuthDataModel({
    required super.accessToken,
    required super.refreshToken,
    required UserEntity user,
  }) : super(user: user);

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': (user as UserModel).toJson(),
    };
  }

  AuthDataEntity toEntity() {
    return AuthDataEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: user,
    );
  }

}
