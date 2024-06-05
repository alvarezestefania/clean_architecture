
import 'package:clean_architecture/features/domain/user/entities/user_entity.dart';

class AuthDataEntity {
  final String accessToken;
  final String refreshToken;
  final UserEntity? user;

  AuthDataEntity({
    required this.accessToken,
    required this.refreshToken,
    this.user
  });
}