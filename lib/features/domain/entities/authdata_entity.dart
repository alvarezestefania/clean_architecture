
import 'package:clean_architecture/features/domain/entities/user_entity.dart';

class AuthDataEntity {
  final String accessToken;
  final String refreshToken;
  final UserEntity? user;
  final String customerId;

  AuthDataEntity({
    required this.accessToken,
    required this.refreshToken,
    this.user,
    required this.customerId
  });
}