import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/data/datasource/customer_datasource.dart';
import 'package:clean_architecture/features/domain/entities/customer_entity.dart';
import 'package:clean_architecture/features/domain/gateways/customer_gateway.dart';

class CustomerRepositoryImpl implements CustomerGateway {
  final CustomerDataSourceService customerDataSourceService;
  CustomerRepositoryImpl(this.customerDataSourceService);

  @override
  Future<void> createCustomer(CustomerEntity customerData) async {
    try {
      await customerDataSourceService.createCustomer(customerData);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<bool> doesCustomerExists(String userId) async {
    try {
      return await customerDataSourceService.doesCustomerExists(userId);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}
