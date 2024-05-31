
import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/entities/authdata_entity.dart';
import 'package:clean_architecture/features/domain/gateways/auth_gateway.dart';

class ListenToAuthStatusUseCase {
  final AuthGateway _authGateway;
  ListenToAuthStatusUseCase(this._authGateway);

  Stream<AuthDataEntity> call() {
    try {
      return _authGateway.listenToAuthStatus();
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}