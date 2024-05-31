import 'package:clean_architecture/features/domain/entities/customer_entity.dart';

abstract class CustomerGateway {
  Future<void> createCustomer(CustomerEntity customerData);
  Future<bool> doesCustomerExists(String userId);
}