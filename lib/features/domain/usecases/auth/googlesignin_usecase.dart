import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/gateways/auth_gateway.dart';

class GoogleSignInUsecase {
  final AuthGateway _authGateway;
  GoogleSignInUsecase(this._authGateway);

  Future<void> call() async {
    try {
      await _authGateway.signInWithGoogle();
    } catch (e) {
      throw CustomException('$e');
    }
  }
}
