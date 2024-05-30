import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/gateways/auth_gateway.dart';

class SignOutUsecase{
  final AuthGateway _authrepository;
  SignOutUsecase(this._authrepository);

  Future<void> call() async {
    try {
      return await _authrepository.signOut();
    } catch (e) {
       throw CustomException('$e');
    }
  }
}