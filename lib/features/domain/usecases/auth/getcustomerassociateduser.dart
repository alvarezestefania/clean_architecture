import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/entities/authdata_entity.dart';
import 'package:clean_architecture/features/domain/gateways/auth_gateway.dart';
import 'package:clean_architecture/features/domain/gateways/customer_gateway.dart';

class GetAuthAndCustomerUseCase {
  final CustomerGateway _customerGateway;
  final AuthGateway _authGateway;
  GetAuthAndCustomerUseCase(this._customerGateway, this._authGateway);

  Future<AuthDataEntity> call() async {
    try {
      final authDataStream = _authGateway.listenToAuthStatus();
      final authResponse =
          await authDataStream.first.then((authData) => authData);
      String? customerId;
      if (authResponse.user != null) {
        final customerResponse =
            await _customerGateway.getCustomerByUserId(authResponse.user!.id);
        customerId = customerResponse?.id;
      }

      return AuthDataEntity(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
        user: authResponse.user,
        customerId: customerId!,
      );
    } catch (e) {
      throw CustomException('$e');
    }
  }
}
