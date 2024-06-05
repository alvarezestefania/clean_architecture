import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/auth/gateways/auth_gateway.dart';

class SignOutUsecase{
  final AuthGateway _authGateway;
  SignOutUsecase(this._authGateway);

  Future<void> call() async {
    try {
      return await _authGateway.signOut();
    } catch (e) {
       throw CustomException('$e');
    }
  }
}