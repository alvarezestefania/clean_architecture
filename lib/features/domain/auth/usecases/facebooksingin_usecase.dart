import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/auth/gateways/auth_gateway.dart';

class FacebookSignInUsecase{
  final AuthGateway _authGateway;
  FacebookSignInUsecase(this._authGateway);

  Future<void> call() async {
    try {
      await _authGateway.signInWithFacebook();  
    } catch (e) {
       throw CustomException('$e');
    }
  }
}