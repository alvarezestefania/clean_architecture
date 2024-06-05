import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/auth/gateways/auth_gateway.dart';

class VerifyPhoneSignInUsecase{
  final AuthGateway _authGateway;
  VerifyPhoneSignInUsecase(this._authGateway);

  Future<void> call(String phoneNumber,String otp) async {
    try {
      await _authGateway.verifyUserPhone(phoneNumber,otp);  
    } catch (e) {
       throw CustomException('$e');
    }
  }
}