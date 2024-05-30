
import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/entities/authdata_entity.dart';
import 'package:clean_architecture/features/domain/gateways/auth_gateway.dart';

class ListenToAuthStatusUseCase {
  final AuthGateway repository;
  ListenToAuthStatusUseCase(this.repository);

  Stream<AuthDataEntity> call() {
    try {
      return repository.listenToAuthStatus();
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}