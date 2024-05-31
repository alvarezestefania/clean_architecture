import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/entities/customer_entity.dart';
import 'package:clean_architecture/features/domain/gateways/customer_gateway.dart';

class CreateCustomerIfNotExistUsecase {
  final CustomerGateway _customerGateway;
  CreateCustomerIfNotExistUsecase(this._customerGateway);

  Future<void> call(String? userId, CustomerEntity customerData) async {
    try {
      final exists = await _customerGateway.doesCustomerExists(userId!); 
      if (!exists) {
        await _customerGateway.createCustomer(customerData);
      }
    } catch (e) {
      throw CustomException('$e');
    }
  }
}
