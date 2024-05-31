import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/gateways/auth_gateway.dart';

class PhoneSignInUsecase{
  final AuthGateway _authGateway;
  PhoneSignInUsecase(this._authGateway);

  Future<void> call(String phoneNumber) async {
    try {
      await _authGateway.signInWithPhone(phoneNumber);  
    } catch (e) {
       throw CustomException('$e');
    }
  }
}