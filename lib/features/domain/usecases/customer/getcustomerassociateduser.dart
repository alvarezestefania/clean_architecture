import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/entities/customer_entity.dart';
import 'package:clean_architecture/features/domain/gateways/customer_gateway.dart';

class GetCustomerByUserIdUseCase {
  final CustomerGateway _customerGateway;
  GetCustomerByUserIdUseCase(this._customerGateway);

  Future<CustomerEntity?> call(String userId) async {
    try {     
      return await _customerGateway.getCustomerByUserId(userId);  
    } catch (e) {
      throw CustomException('$e');
    }
  }
}
